package core

import (
	"errors"
	"math"

	arwenConfig "github.com/ElrondNetwork/arwen-wasm-vm/config"
	"github.com/ElrondNetwork/elrond-go-node-debug/internal/myaccounts"
	"github.com/ElrondNetwork/elrond-go-node-debug/internal/mystorage"
	"github.com/ElrondNetwork/elrond-go-node-debug/internal/shared"
	"github.com/ElrondNetwork/elrond-go-node-debug/internal/stubs"
	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/typeConverters/uint64ByteSlice"
	"github.com/ElrondNetwork/elrond-go/facade"
	"github.com/ElrondNetwork/elrond-go/hashing/sha256"
	"github.com/ElrondNetwork/elrond-go/integrationTests/mock"
	"github.com/ElrondNetwork/elrond-go/marshal"
	"github.com/ElrondNetwork/elrond-go/node/external"
	"github.com/ElrondNetwork/elrond-go/process"
	"github.com/ElrondNetwork/elrond-go/process/coordinator"
	"github.com/ElrondNetwork/elrond-go/process/factory/shard"
	"github.com/ElrondNetwork/elrond-go/process/smartContract"
	"github.com/ElrondNetwork/elrond-go/process/smartContract/hooks"
	"github.com/ElrondNetwork/elrond-go/process/transaction"
	"github.com/ElrondNetwork/elrond-go/sharding"
	"github.com/ElrondNetwork/elrond-go/statusHandler"
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
)

var Marshalizer = &marshal.JsonMarshalizer{}
var Hasher = sha256.Sha256{}
var shardCoordinator, _ = sharding.NewMultiShardCoordinator(1, 0)
var GasMap = arwenConfig.MakeGasMap(1)

type SimpleDebugNode struct {
	Accounts         state.AccountsAdapter
	TxProcessor      process.TransactionProcessor
	BlockChainHook   process.BlockChainHookHandler
	AddressConverter state.AddressConverter
	VMContainer      process.VirtualMachinesContainer
	SCQueryService   external.SCQueryService
	APIResolver      facade.ApiResolver
}

func NewSimpleDebugNode(accounts state.AccountsAdapter) (*SimpleDebugNode, error) {
	if accounts == nil || accounts.IsInterfaceNil() {
		return nil, errors.New("nil accounts adapter")
	}

	node := &SimpleDebugNode{
		Accounts:         accounts,
		TxProcessor:      nil,
		BlockChainHook:   nil,
		AddressConverter: shared.AddressConverter,
	}

	argBlockChainHook := hooks.ArgBlockChainHook{
		Accounts:         accounts,
		AddrConv:         shared.AddressConverter,
		StorageService:   mystorage.CreateStorageService(),
		BlockChain:       mystorage.CreateBlockChain(),
		ShardCoordinator: shardCoordinator,
		Marshalizer:      Marshalizer,
		Uint64Converter:  uint64ByteSlice.NewBigEndianConverter(),
	}

	vmFactory, err := shard.NewVMContainerFactory(math.MaxUint64, GasMap, argBlockChainHook)
	if err != nil {
		return nil, err
	}

	vmContainer, err := vmFactory.Create()
	if err != nil {
		return nil, err
	}

	argsParser := vmcommon.NewAtArgumentParser()

	txTypeHandler, err := coordinator.NewTxTypeHandler(shared.AddressConverter, shardCoordinator, accounts)
	if err != nil {
		return nil, err
	}

	scProcessorArgs := smartContract.ArgsNewSmartContractProcessor{
		VmContainer:   vmContainer,
		ArgsParser:    argsParser,
		Hasher:        Hasher,
		Marshalizer:   Marshalizer,
		AccountsDB:    accounts,
		TempAccounts:  vmFactory.BlockChainHookImpl(),
		AdrConv:       shared.AddressConverter,
		Coordinator:   shardCoordinator,
		ScrForwarder:  &mock.IntermediateTransactionHandlerMock{},
		TxFeeHandler:  &stubs.MyTransactionFeeHandlerStub{},
		EconomicsFee:  &stubs.MyFeeHandlerStub{},
		TxTypeHandler: txTypeHandler,
		GasHandler:    &stubs.MyGasHandlerStub{},
		GasMap:        GasMap,
	}

	scProcessor, err := smartContract.NewSmartContractProcessor(scProcessorArgs)
	if err != nil {
		return nil, err
	}

	txProcessor, err := transaction.NewTxProcessor(
		accounts,
		Hasher,
		shared.AddressConverter,
		Marshalizer,
		shardCoordinator,
		scProcessor,
		&stubs.MyTransactionFeeHandlerStub{},
		txTypeHandler,
		&stubs.MyFeeHandlerStub{},
		&mock.IntermediateTransactionHandlerMock{},
		&mock.IntermediateTransactionHandlerMock{},
	)
	if err != nil {
		return nil, err
	}

	statusMetrics := statusHandler.NewStatusMetrics()

	scQueryService, err := smartContract.NewSCQueryService(vmContainer, uint64(1000000))
	if err != nil {
		return nil, err
	}

	apiResolver, err := external.NewNodeApiResolver(scQueryService, statusMetrics)
	if err != nil {
		return nil, err
	}

	node.VMContainer = vmContainer
	node.TxProcessor = txProcessor
	node.BlockChainHook = vmFactory.BlockChainHookImpl()
	node.SCQueryService = scQueryService
	node.APIResolver = apiResolver

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
		_ = myaccounts.CreateAccount(node.Accounts, []byte(pubKey), 0, value)
	}

	return nil
}
