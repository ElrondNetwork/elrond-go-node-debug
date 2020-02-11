package mystorage

import (
	"github.com/ElrondNetwork/elrond-go-node-debug/internal/myaccounts"
	"github.com/ElrondNetwork/elrond-go/config"
	dataBlock "github.com/ElrondNetwork/elrond-go/data/block"
	"github.com/ElrondNetwork/elrond-go/data/blockchain"
	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/trie"
	"github.com/ElrondNetwork/elrond-go/data/trie/evictionWaitingList"
	"github.com/ElrondNetwork/elrond-go/dataRetriever"
	"github.com/ElrondNetwork/elrond-go/hashing/sha256"
	"github.com/ElrondNetwork/elrond-go/marshal"
	"github.com/ElrondNetwork/elrond-go/storage"
	"github.com/ElrondNetwork/elrond-go/storage/memorydb"
	"github.com/ElrondNetwork/elrond-go/storage/storageUnit"
)

var hasher = sha256.Sha256{}
var marshalizer = marshal.JsonMarshalizer{}

// CreateStorageService creates a storage service
func CreateStorageService() dataRetriever.StorageService {
	store := dataRetriever.NewChainStorer()
	store.AddStorer(dataRetriever.TransactionUnit, CreateMemUnit())
	store.AddStorer(dataRetriever.MiniBlockUnit, CreateMemUnit())
	store.AddStorer(dataRetriever.MetaBlockUnit, CreateMemUnit())
	store.AddStorer(dataRetriever.PeerChangesUnit, CreateMemUnit())
	store.AddStorer(dataRetriever.BlockHeaderUnit, CreateMemUnit())
	store.AddStorer(dataRetriever.UnsignedTransactionUnit, CreateMemUnit())
	store.AddStorer(dataRetriever.RewardTransactionUnit, CreateMemUnit())
	store.AddStorer(dataRetriever.MetaHdrNonceHashDataUnit, CreateMemUnit())

	hdrNonceHashDataUnit := dataRetriever.ShardHdrNonceHashDataUnit + dataRetriever.UnitType(1)
	store.AddStorer(hdrNonceHashDataUnit, CreateMemUnit())

	return store
}

// CreateMemUnit creates a memory unit (storer)
func CreateMemUnit() storage.Storer {
	cache, _ := storageUnit.NewCache(storageUnit.LRUCache, 10, 1)
	persist := memorydb.New()
	unit, _ := storageUnit.NewStorageUnit(cache, persist)

	return unit
}

// CreateBlockChain creates a blockchain
func CreateBlockChain() *blockchain.BlockChain {
	cfgCache := storageUnit.CacheConfig{Size: 100, Type: storageUnit.LRUCache}
	badBlockCache, _ := storageUnit.NewCache(cfgCache.Type, cfgCache.Size, cfgCache.Shards)
	blockChain, _ := blockchain.NewBlockChain(
		badBlockCache,
	)
	blockChain.GenesisHeader = &dataBlock.Header{}
	genesisHeaderM, _ := marshalizer.Marshal(blockChain.GenesisHeader)

	blockChain.SetGenesisHeaderHash(hasher.Compute(string(genesisHeaderM)))
	return blockChain
}

// CreateInMemoryShardAccountsDB creates an accounts db
func CreateInMemoryShardAccountsDB() *state.AccountsDB {
	store := CreateMemUnit()
	waitingList, _ := evictionWaitingList.NewEvictionWaitingList(100, memorydb.New(), &marshalizer)
	trieStorage, _ := trie.NewTrieStorageManager(store, &config.DBConfig{}, waitingList)
	tr, _ := trie.NewTrie(trieStorage, &marshalizer, hasher)
	accountsDb, _ := state.NewAccountsDB(tr, hasher, &marshalizer, &myaccounts.AccountFactory{})

	return accountsDb
}
