package node

import (
	"encoding/hex"
	"errors"
	"math/big"

	debugInit "github.com/ElrondNetwork/elrond-go-node-debug/process"
	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/state/addressConverters"
	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/ElrondNetwork/elrond-go/process"
	"github.com/ElrondNetwork/elrond-go/process/factory"
	"github.com/ElrondNetwork/elrond-go/sharding"
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
)

// ProcessSmartContract is the interface that holds functions for processing smart contracts.
type ProcessSmartContract interface {
	DeploySmartContract(command DeploySmartContractCommand) ([]byte, error)
	RunSmartContract(command RunSmartContractCommand) ([]byte, error)
	IsInterfaceNil() bool
}

// DeploySmartContractCommand represents the command for deploying a smart contract.
type DeploySmartContractCommand struct {
	OnTestnet           bool
	PrivateKey          string
	TestnetNodeEndpoint string
	SndAddress          string
	Code                string
	ArgsBuff            [][]byte
}

// RunSmartContractCommand represents the command for running a smart contract.
type RunSmartContractCommand struct {
	OnTestnet           bool
	PrivateKey          string
	TestnetNodeEndpoint string
	SndAddress          string
	ScAddress           string
	Value               string
	GasPrice            uint64
	GasLimit            uint64
	FuncName            string
	FuncArgsBuff        [][]byte
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

// DeploySmartContract deploys a smart contract (with its code).
func (node *SimpleDebugNode) DeploySmartContract(command DeploySmartContractCommand) ([]byte, error) {
	if command.OnTestnet {
		return node.deploySmartContractOnTestnet(command)
	}

	return node.deploySmartContractOnDebugNode(command)
}

func (node *SimpleDebugNode) deploySmartContractOnDebugNode(command DeploySmartContractCommand) ([]byte, error) {
	accAddress, err := node.addrConverter.CreateAddressFromPublicKeyBytes([]byte(command.SndAddress))
	if err != nil {
		return nil, err
	}

	account, err := node.acnts.GetAccountWithJournal(accAddress)
	if err != nil {
		return nil, err
	}

	txData := command.Code + "@" + hex.EncodeToString(factory.ArwenVirtualMachine)
	for _, arg := range command.ArgsBuff {
		txData += "@" + hex.EncodeToString(arg)
	}

	resultingAddress, err := node.blockChainHook.NewAddress([]byte(command.SndAddress), account.GetNonce(), factory.ArwenVirtualMachine)
	if err != nil {
		return nil, err
	}

	tx := &transaction.Transaction{
		Nonce:     account.GetNonce(),
		Value:     big.NewInt(0),
		RcvAddr:   debugInit.CreateEmptyAddress().Bytes(),
		SndAddr:   []byte(command.SndAddress),
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

func (node *SimpleDebugNode) deploySmartContractOnTestnet(command DeploySmartContractCommand) ([]byte, error) {
	return nil, nil
}

// RunSmartContract runs a smart contract (a function defined by the smart contract).
func (node *SimpleDebugNode) RunSmartContract(command RunSmartContractCommand) ([]byte, error) {
	accAddress, err := node.addrConverter.CreateAddressFromPublicKeyBytes([]byte(command.SndAddress))
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

	valueAsString := command.Value
	value, ok := big.NewInt(0).SetString(valueAsString, 10)
	if !ok {
		return nil, errors.New("value is not in base 10 format")
	}

	if stAcc.Balance.Cmp(value) < 0 {
		err = stAcc.SetBalanceWithJournal(value)
		if err != nil {
			return nil, err
		}
	}

	txData := command.FuncName
	for _, arg := range command.FuncArgsBuff {
		txData += "@" + hex.EncodeToString(arg)
	}

	tx := &transaction.Transaction{
		Nonce:     account.GetNonce(),
		Value:     value,
		RcvAddr:   []byte(command.ScAddress),
		SndAddr:   []byte(command.SndAddress),
		GasPrice:  command.GasPrice,
		GasLimit:  command.GasLimit,
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
