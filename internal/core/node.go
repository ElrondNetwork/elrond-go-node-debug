package core

import (
	"encoding/hex"
	"errors"
	"fmt"
	"math/big"

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
var oneShardCoordinator = mock.NewMultiShardsCoordinatorMock(1)
var addrConv, _ = addressConverters.NewPlainAddressConverter(32, "0x")

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
		_ = CreateAccount(node.acnts, []byte(pubKey), 0, value)
	}

	node.txProcessor, node.blockChainHook = CreateTxProcessorWithOneSCExecutorWithVMs(node.acnts)

	return node, nil
}

const defaultRound uint64 = 444

func CreateTxProcessorWithOneSCExecutorWithVMs(accnts state.AccountsAdapter) (process.TransactionProcessor, vmcommon.BlockchainHook) {

	vmFactory, _ := shard.NewVMContainerFactory(accnts, addrConv)
	vmContainer, _ := vmFactory.Create()

	argsParser, _ := smartContract.NewAtArgumentParser()
	scProcessor, _ := smartContract.NewSmartContractProcessor(
		vmContainer,
		argsParser,
		hasher,
		marshalizer,
		accnts,
		vmFactory.VMAccountsDB(),
		addrConv,
		oneShardCoordinator,
		&mock.IntermediateTransactionHandlerMock{},
		&MyTransactionFeeHandlerStub{},
	)

	txTypeHandler, _ := coordinator.NewTxTypeHandler(addrConv, oneShardCoordinator, accnts)

	txProcessor, _ := transaction.NewTxProcessor(
		accnts,
		hasher,
		addrConv,
		marshalizer,
		oneShardCoordinator,
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

	address, _ := addrConv.CreateAddressFromPublicKeyBytes(pubKey)
	account, _ := accnts.GetAccountWithJournal(address)
	_ = account.(*state.Account).SetNonceWithJournal(nonce)
	_ = account.(*state.Account).SetBalanceWithJournal(balance)

	hashCreated, _ := accnts.Commit()
	return hashCreated
}
