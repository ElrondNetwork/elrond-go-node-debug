package process

import (
	"math/big"

	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/state/addressConverters"
	"github.com/ElrondNetwork/elrond-go/data/trie"
	"github.com/ElrondNetwork/elrond-go/hashing/sha256"
	"github.com/ElrondNetwork/elrond-go/integrationTests/mock"
	"github.com/ElrondNetwork/elrond-go/marshal"
	"github.com/ElrondNetwork/elrond-go/process"
	"github.com/ElrondNetwork/elrond-go/process/factory/shard"
	"github.com/ElrondNetwork/elrond-go/process/smartContract"
	"github.com/ElrondNetwork/elrond-go/process/smartContract/hooks"
	"github.com/ElrondNetwork/elrond-go/process/transaction"
	"github.com/ElrondNetwork/elrond-go/storage"
	"github.com/ElrondNetwork/elrond-go/storage/memorydb"
	"github.com/ElrondNetwork/elrond-go/storage/storageUnit"
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
)

var testMarshalizer = &marshal.JsonMarshalizer{}
var testHasher = sha256.Sha256{}
var oneShardCoordinator = mock.NewMultiShardsCoordinatorMock(1)
var addrConv, _ = addressConverters.NewPlainAddressConverter(32, "0x")

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

func CreateMemUnit() storage.Storer {
	cache, _ := storageUnit.NewCache(storageUnit.LRUCache, 10, 1)
	persist, _ := memorydb.New()

	unit, _ := storageUnit.NewStorageUnit(cache, persist)
	return unit
}

func CreateInMemoryShardAccountsDB() *state.AccountsDB {
	marsh := &marshal.JsonMarshalizer{}
	store := CreateMemUnit()

	tr, _ := trie.NewTrie(store, marsh, testHasher)
	adb, _ := state.NewAccountsDB(tr, testHasher, marsh, &accountFactory{})

	return adb
}

func CreateEmptyAddress() state.AddressContainer {
	buff := make([]byte, testHasher.Size())

	return state.NewAddress(buff)
}

func CreateAccount(accnts state.AccountsAdapter, pubKey []byte, nonce uint64, balance *big.Int) []byte {
	address, _ := addrConv.CreateAddressFromPublicKeyBytes(pubKey)
	account, _ := accnts.GetAccountWithJournal(address)
	_ = account.(*state.Account).SetNonceWithJournal(nonce)
	_ = account.(*state.Account).SetBalanceWithJournal(balance)

	hashCreated, _ := accnts.Commit()
	return hashCreated
}

func CreateTxProcessorWithOneSCExecutorWithVMs(
	accnts state.AccountsAdapter,
) (process.TransactionProcessor, vmcommon.BlockchainHook) {

	vmFactory, _ := shard.NewVMContainerFactory(accnts, addrConv)
	vmContainer, _ := vmFactory.Create()

	argsParser, _ := smartContract.NewAtArgumentParser()
	scProcessor, _ := smartContract.NewSmartContractProcessor(
		vmContainer,
		argsParser,
		testHasher,
		testMarshalizer,
		accnts,
		vmFactory.VMAccountsDB(),
		addrConv,
		oneShardCoordinator,
		&mock.IntermediateTransactionHandlerMock{},
	)
	txProcessor, _ := transaction.NewTxProcessor(accnts, testHasher, addrConv, testMarshalizer, oneShardCoordinator, scProcessor)

	return txProcessor, vmFactory.VMAccountsDB()
}

func CreatePreparedTxProcessorAndAccountsWithVMs(
	senderNonce uint64,
	senderAddressBytes []byte,
	senderBalance *big.Int,
) (process.TransactionProcessor, state.AccountsAdapter, vmcommon.BlockchainHook) {

	accnts := CreateInMemoryShardAccountsDB()
	_ = CreateAccount(accnts, senderAddressBytes, senderNonce, senderBalance)

	txProcessor, blockchainHook := CreateTxProcessorWithOneSCExecutorWithVMs(accnts)

	return txProcessor, accnts, blockchainHook
}

func GetAccountsBalance(addrBytes []byte, accnts state.AccountsAdapter) *big.Int {
	address, _ := addrConv.CreateAddressFromPublicKeyBytes(addrBytes)
	accnt, _ := accnts.GetExistingAccount(address)
	shardAccnt, _ := accnt.(*state.Account)

	return shardAccnt.Balance
}

func CreateVMsContainerAndBlockchainHook(accnts state.AccountsAdapter) (process.VirtualMachinesContainer, *hooks.VMAccountsDB) {
	blockChainHook, _ := hooks.NewVMAccountsDB(accnts, addrConv)

	vmFactory, _ := shard.NewVMContainerFactory(accnts, addrConv)
	vmContainer, _ := vmFactory.Create()

	return vmContainer, blockChainHook
}

func GetIntValueFromSC(accnts state.AccountsAdapter, scAddressBytes []byte, funcName string, args ...[]byte) *big.Int {
	vmContainer, _ := CreateVMsContainerAndBlockchainHook(accnts)
	scgd, _ := smartContract.NewSCDataGetter(vmContainer)

	returnedVals, _ := scgd.Get(scAddressBytes, funcName, args...)
	return big.NewInt(0).SetBytes(returnedVals)
}
