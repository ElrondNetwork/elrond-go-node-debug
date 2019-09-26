package node

import (
	"encoding/hex"
	"errors"
	debugInit "github.com/ElrondNetwork/elrond-go-node-debug/process"
	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/state/addressConverters"
	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/ElrondNetwork/elrond-go/process"
	"github.com/ElrondNetwork/elrond-go/process/factory"
	"github.com/ElrondNetwork/elrond-go/sharding"
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
	"math/big"
)

type ProcessSmartContract interface {
	DeploySmartContract(address string, code string, argsBuff ...[]byte) ([]byte, error)
	RunSmartContract(sndAddress string, scAddress string, value string, funcName string, argsBuff ...[]byte) ([]byte, error)
	IsInterfaceNil() bool
}

type SimpleDebugNode struct {
	acnts          state.AccountsAdapter
	txProcessor    process.TransactionProcessor
	blockChainHook vmcommon.BlockchainHook
	addrConverter  state.AddressConverter
}

func NewSimpleDebugNode(accnts state.AccountsAdapter, genesisFile string) (*SimpleDebugNode, error) {
	genesisConfig, err := sharding.NewGenesisConfig(genesisFile)
	if err != nil {
		return nil, err
	}

	if accnts == nil || accnts.IsInterfaceNil() {
		return nil, errors.New("nil accounts adapter")
	}

	node := &SimpleDebugNode{
		acnts:          accnts,
		txProcessor:    nil,
		blockChainHook: nil,
	}

	shardC, err := sharding.NewMultiShardCoordinator(1, 0)
	if err != nil {
		return nil, err
	}

	node.addrConverter, err = addressConverters.NewPlainAddressConverter(32, "0x")
	if err != nil {
		return nil, err
	}

	mapInValues, err := genesisConfig.InitialNodesBalances(shardC, node.addrConverter)
	if err != nil {
		return nil, err
	}

	for pubKey, value := range mapInValues {
		_ = debugInit.CreateAccount(node.acnts, []byte(pubKey), 0, value)
	}

	node.txProcessor, node.blockChainHook = debugInit.CreateTxProcessorWithOneSCExecutorWithVMs(node.acnts)

	return node, nil
}

const defaultRound uint64 = 444

func (node *SimpleDebugNode) DeploySmartContract(address string, code string, argsBuff ...[]byte) ([]byte, error) {
	accAddress, err := node.addrConverter.CreateAddressFromPublicKeyBytes([]byte(address))
	if err != nil {
		return nil, err
	}

	account, err := node.acnts.GetAccountWithJournal(accAddress)
	if err != nil {
		return nil, err
	}

	txData := code + "@" + hex.EncodeToString(factory.ArwenVirtualMachine)
	for _, arg := range argsBuff {
		txData += "@" + hex.EncodeToString(arg)
	}

	resultingAddress, err := node.blockChainHook.NewAddress([]byte(address), account.GetNonce(), factory.ArwenVirtualMachine)
	if err != nil {
		return nil, err
	}

	tx := &transaction.Transaction{
		Nonce:     account.GetNonce(),
		Value:     big.NewInt(0),
		RcvAddr:   debugInit.CreateEmptyAddress().Bytes(),
		SndAddr:   []byte(address),
		GasPrice:  0,
		GasLimit:  10000,
		Data:      txData,
		Signature: nil,
		Challenge: nil,
	}

	err = node.txProcessor.ProcessTransaction(tx, defaultRound)
	if err != nil {
		return nil, err
	}

	_, err = node.acnts.Commit()
	if err != nil {
		return nil, err
	}

	return resultingAddress, nil
}

func (node *SimpleDebugNode) RunSmartContract(sndAddress string, scAddress string, value string, funcName string, argsBuff ...[]byte) ([]byte, error) {
	accAddress, err := node.addrConverter.CreateAddressFromPublicKeyBytes([]byte(sndAddress))
	if err != nil {
		return nil, err
	}

	account, err := node.acnts.GetAccountWithJournal(accAddress)
	if err != nil {
		return nil, err
	}

	stAcc, ok := account.(*state.Account)
	if !ok {
		return nil, errors.New("wrong type of account")
	}

	val, ok := big.NewInt(0).SetString(value, 10)
	if !ok {
		return nil, errors.New("value is not in base 10 format")
	}

	if stAcc.Balance.Cmp(val) < 0 {
		err = stAcc.SetBalanceWithJournal(val)
		if err != nil {
			return nil, err
		}
	}

	txData := funcName
	for _, arg := range argsBuff {
		txData += "@" + hex.EncodeToString(arg)
	}

	tx := &transaction.Transaction{
		Nonce:     account.GetNonce(),
		Value:     val,
		RcvAddr:   []byte(scAddress),
		SndAddr:   []byte(sndAddress),
		GasPrice:  0,
		GasLimit:  10000,
		Data:      txData,
		Signature: nil,
		Challenge: nil,
	}

	err = node.txProcessor.ProcessTransaction(tx, defaultRound)
	if err != nil {
		return nil, err
	}

	return node.acnts.Commit()
}

func (node *SimpleDebugNode) IsInterfaceNil() bool {
	if node == nil {
		return true
	}
	return false
}
