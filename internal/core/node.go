package core

import (
	"encoding/hex"
	"errors"
	"fmt"
	"math"
	"math/big"

	arwenConfig "github.com/ElrondNetwork/arwen-wasm-vm/config"
	"github.com/ElrondNetwork/elrond-go-node-debug/internal/core/stubs"
	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/state/addressConverters"
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
var addressConverter, _ = addressConverters.NewPlainAddressConverter(32, "0x")
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
		AddressConverter: addressConverter,
	}

	argBlockChainHook := hooks.ArgBlockChainHook{
		Accounts:         accounts,
		AddrConv:         addressConverter,
		StorageService:   CreateStorageService(),
		BlockChain:       CreateBlockChain(),
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

	argsParser, err := vmcommon.NewAtArgumentParser()
	if err != nil {
		return nil, err
	}

	txTypeHandler, err := coordinator.NewTxTypeHandler(addressConverter, shardCoordinator, accounts)
	if err != nil {
		return nil, err
	}

	scProcessor, err := smartContract.NewSmartContractProcessor(
		vmContainer,
		argsParser,
		Hasher,
		Marshalizer,
		accounts,
		vmFactory.BlockChainHookImpl(),
		addressConverter,
		shardCoordinator,
		&mock.IntermediateTransactionHandlerMock{},
		&stubs.MyTransactionFeeHandlerStub{},
		&mock.FeeHandlerStub{},
		txTypeHandler,
		&stubs.MyGasHandlerStub{},
	)
	if err != nil {
		return nil, err
	}

	txProcessor, err := transaction.NewTxProcessor(
		accounts,
		Hasher,
		addressConverter,
		Marshalizer,
		shardCoordinator,
		scProcessor,
		&stubs.MyTransactionFeeHandlerStub{},
		txTypeHandler,
		&stubs.MyFeeHandlerStub{},
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
		_ = CreateAccount(node.Accounts, []byte(pubKey), 0, value)
	}

	return nil
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
	buff := make([]byte, Hasher.Size())

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
