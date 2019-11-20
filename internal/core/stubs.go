package core

import (
	"math/big"

	dataBlock "github.com/ElrondNetwork/elrond-go/data/block"
	"github.com/ElrondNetwork/elrond-go/data/blockchain"
	"github.com/ElrondNetwork/elrond-go/dataRetriever"
	"github.com/ElrondNetwork/elrond-go/process"
	"github.com/ElrondNetwork/elrond-go/storage"
	"github.com/ElrondNetwork/elrond-go/storage/memorydb"
	"github.com/ElrondNetwork/elrond-go/storage/storageUnit"
)

// MyTransactionFeeHandlerStub is a stub.
type MyTransactionFeeHandlerStub struct {
}

// ProcessTransactionFee is a stub.
func (stub *MyTransactionFeeHandlerStub) ProcessTransactionFee(cost *big.Int) {
}

// IsInterfaceNil is a stub.
func (stub *MyTransactionFeeHandlerStub) IsInterfaceNil() bool {
	return false
}

// MyFeeHandlerStub is a stub.
type MyFeeHandlerStub struct {
}

// ComputeGasLimit is a stub.
func (stub *MyFeeHandlerStub) ComputeGasLimit(tx process.TransactionWithFeeHandler) uint64 {
	return 0
}

// ComputeFee is a stub.
func (stub *MyFeeHandlerStub) ComputeFee(tx process.TransactionWithFeeHandler) *big.Int {
	return big.NewInt(0)
}

// CheckValidityTxValues is a stub.
func (stub *MyFeeHandlerStub) CheckValidityTxValues(tx process.TransactionWithFeeHandler) error {
	return nil
}

// IsInterfaceNil is a stub.
func (stub *MyFeeHandlerStub) IsInterfaceNil() bool {
	return false
}

func CreateStorageService() dataRetriever.StorageService {
	store := dataRetriever.NewChainStorer()
	store.AddStorer(dataRetriever.TransactionUnit, createMemUnit())
	store.AddStorer(dataRetriever.MiniBlockUnit, createMemUnit())
	store.AddStorer(dataRetriever.MetaBlockUnit, createMemUnit())
	store.AddStorer(dataRetriever.PeerChangesUnit, createMemUnit())
	store.AddStorer(dataRetriever.BlockHeaderUnit, createMemUnit())
	store.AddStorer(dataRetriever.UnsignedTransactionUnit, createMemUnit())
	store.AddStorer(dataRetriever.RewardTransactionUnit, createMemUnit())
	store.AddStorer(dataRetriever.MetaHdrNonceHashDataUnit, createMemUnit())

	hdrNonceHashDataUnit := dataRetriever.ShardHdrNonceHashDataUnit + dataRetriever.UnitType(1)
	store.AddStorer(hdrNonceHashDataUnit, createMemUnit())

	return store
}

func createMemUnit() storage.Storer {
	cache, _ := storageUnit.NewCache(storageUnit.LRUCache, 10, 1)
	persist, _ := memorydb.New()
	unit, _ := storageUnit.NewStorageUnit(cache, persist)

	return unit
}

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
