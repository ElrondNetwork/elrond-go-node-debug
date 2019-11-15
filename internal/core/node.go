package core

import (
	"encoding/hex"
	"errors"
	"fmt"
	"math"
	"math/big"

	arwenConfig "github.com/ElrondNetwork/arwen-wasm-vm/config"
	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/state/addressConverters"
	"github.com/ElrondNetwork/elrond-go/hashing/sha256"
	"github.com/ElrondNetwork/elrond-go/integrationTests/mock"
	"github.com/ElrondNetwork/elrond-go/marshal"
	"github.com/ElrondNetwork/elrond-go/process"
	"github.com/ElrondNetwork/elrond-go/process/coordinator"
	"github.com/ElrondNetwork/elrond-go/process/factory/shard"
	"github.com/ElrondNetwork/elrond-go/process/smartContract"
	"github.com/ElrondNetwork/elrond-go/process/transaction"
	"github.com/ElrondNetwork/elrond-go/sharding"
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
)

var marshalizer = &marshal.JsonMarshalizer{}
var hasher = sha256.Sha256{}
var shardCoordinator, _ = sharding.NewMultiShardCoordinator(1, 0)
var addressConverter, _ = addressConverters.NewPlainAddressConverter(32, "0x")
var GasMap = arwenConfig.MakeGasMap(1)

type SimpleDebugNode struct {
	Accounts         state.AccountsAdapter
	TxProcessor      process.TransactionProcessor
	BlockChainHook   vmcommon.BlockchainHook
	AddressConverter state.AddressConverter
	VMContainer      process.VirtualMachinesContainer
}

func NewSimpleDebugNode(accounts state.AccountsAdapter) (*SimpleDebugNode, error) {
	if accounts == nil || accounts.IsInterfaceNil() {
		return nil, errors.New("nil accounts adapter")
	}

	node := &SimpleDebugNode{
		Accounts:         accounts,
		TxProcessor:      nil,
		BlockChainHook:   nil,
		AddressConverter: addressConverter,
	}

	node.TxProcessor, node.BlockChainHook = CreateTxProcessorWithOneSCExecutorWithVMs(node.Accounts)

	return node, nil
}

func (node *SimpleDebugNode) AddAccountsAccordingToGenesisFile(genesisFile string) error {
	genesisConfig, err := sharding.NewGenesisConfig(genesisFile)
	if err != nil {
		return err
	}

	mapInValues, err := genesisConfig.InitialNodesBalances(shardCoordinator, node.AddressConverter)
	if err != nil {
		return err
	}

	for pubKey, value := range mapInValues {
		_ = CreateAccount(node.Accounts, []byte(pubKey), 0, value)
	}

	return nil
}

const DefaultRound uint64 = 444

func CreateTxProcessorWithOneSCExecutorWithVMs(accnts state.AccountsAdapter) (process.TransactionProcessor, vmcommon.BlockchainHook) {
	vmFactory, _ := shard.NewVMContainerFactory(accnts, addressConverter, math.MaxUint64, GasMap)
	vmContainer, _ := vmFactory.Create()

	argsParser, _ := smartContract.NewAtArgumentParser()
	scProcessor, _ := smartContract.NewSmartContractProcessor(
		vmContainer,
		argsParser,
		hasher,
		marshalizer,
		accnts,
		vmFactory.VMAccountsDB(),
		addressConverter,
		shardCoordinator,
		&mock.IntermediateTransactionHandlerMock{},
		&MyTransactionFeeHandlerStub{},
	)

	txTypeHandler, _ := coordinator.NewTxTypeHandler(addressConverter, shardCoordinator, accnts)

	txProcessor, _ := transaction.NewTxProcessor(
		accnts,
		hasher,
		addressConverter,
		marshalizer,
		shardCoordinator,
		scProcessor,
		&MyTransactionFeeHandlerStub{},
		txTypeHandler,
		&MyFeeHandlerStub{},
	)

	return txProcessor, vmFactory.VMAccountsDB()
}

type accountFactory struct {
}

func (af *accountFactory) CreateAccount(address state.AddressContainer, tracker state.AccountTracker) (state.AccountHandler, error) {
	return state.NewAccount(address, tracker)
}

// IsInterfaceNil returns true if there is no value under the interface
func (af *accountFactory) IsInterfaceNil() bool {
	if af == nil {
		return true
	}
	return false
}

func CreateEmptyAddress() state.AddressContainer {
	buff := make([]byte, hasher.Size())

	return state.NewAddress(buff)
}

func CreateAccount(accnts state.AccountsAdapter, pubKey []byte, nonce uint64, balance *big.Int) []byte {
	fmt.Printf("CreateAccount %s, balance = %s\n", hex.EncodeToString(pubKey), balance.String())

	address, _ := addressConverter.CreateAddressFromPublicKeyBytes(pubKey)
	account, _ := accnts.GetAccountWithJournal(address)
	_ = account.(*state.Account).SetNonceWithJournal(nonce)
	_ = account.(*state.Account).SetBalanceWithJournal(balance)

	hashCreated, _ := accnts.Commit()
	return hashCreated
}
