package core

import (
	"encoding/hex"
	"io/ioutil"
	"math"
	"math/big"
	"strconv"
	"testing"

	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/ElrondNetwork/elrond-go/data/trie"
	"github.com/ElrondNetwork/elrond-go/marshal"
	"github.com/ElrondNetwork/elrond-go/process"
	"github.com/ElrondNetwork/elrond-go/process/factory"
	"github.com/ElrondNetwork/elrond-go/process/factory/shard"
	"github.com/ElrondNetwork/elrond-go/process/smartContract"
	"github.com/ElrondNetwork/elrond-go/storage"
	"github.com/ElrondNetwork/elrond-go/storage/memorydb"
	"github.com/ElrondNetwork/elrond-go/storage/storageUnit"
	"github.com/stretchr/testify/assert"
)

func TestER20_C_Old(t *testing.T) {
	ownerNonce := uint64(1)
	ownerAddress := []byte("12345678901234567890123456789012")
	ownerBalance := big.NewInt(100000000)
	aliceAddress := []byte("12345678901234567890123456789111")
	aliceNonce := uint64(1)
	aliceInit := big.NewInt(100000)
	bobAddress := []byte("12345678901234567890123456789222")
	bobNonce := uint64(1)
	round := uint64(444)
	transferOnCalls := big.NewInt(5)

	accounts := createInMemoryShardAccountsDB()
	_ = CreateAccount(accounts, ownerAddress, ownerNonce, ownerBalance)
	_ = CreateAccount(accounts, aliceAddress, aliceNonce, big.NewInt(1000000))
	_ = CreateAccount(accounts, bobAddress, bobNonce, big.NewInt(1000000))

	txProc, blockchainHook := CreateTxProcessorWithOneSCExecutorWithVMs(accounts)

	smartContractCode := getSmartContractCode("wrc20_arwen_c_old.wasm")

	tx := &transaction.Transaction{
		Nonce:     ownerNonce,
		Value:     big.NewInt(0),
		RcvAddr:   CreateEmptyAddress().Bytes(),
		SndAddr:   ownerAddress,
		GasPrice:  1,
		GasLimit:  500000,
		Data:      smartContractCode + "@" + hex.EncodeToString(factory.ArwenVirtualMachine),
		Signature: nil,
		Challenge: nil,
	}

	err := txProc.ProcessTransaction(tx, round)
	assert.Nil(t, err)

	_, err = accounts.Commit()
	assert.Nil(t, err)

	scAddress, _ := blockchainHook.NewAddress(ownerAddress, ownerNonce, factory.ArwenVirtualMachine)

	tx = &transaction.Transaction{
		Nonce:    aliceNonce,
		Value:    aliceInit,
		RcvAddr:  scAddress,
		SndAddr:  aliceAddress,
		GasPrice: 1,
		GasLimit: 500000,
		Data:     "topUp",
	}

	err = txProc.ProcessTransaction(tx, round)
	assert.Nil(t, err)

	_, err = accounts.Commit()
	assert.Nil(t, err)

	aliceNonce++

	nrTxs := 10

	for i := 0; i < nrTxs; i++ {
		transferToken(txProc, scAddress, "transfer", aliceAddress, &aliceNonce, bobAddress, 5)
	}

	_, err = accounts.Commit()
	assert.Nil(t, err)

	finalAlice := big.NewInt(0).Sub(aliceInit, big.NewInt(int64(nrTxs)*transferOnCalls.Int64()))
	assert.Equal(t, finalAlice.Uint64(), getBalance(accounts, scAddress, aliceAddress).Uint64())
	finalBob := big.NewInt(int64(nrTxs) * transferOnCalls.Int64())
	assert.Equal(t, finalBob.Uint64(), getBalance(accounts, scAddress, bobAddress).Uint64())
}

func getSmartContractCode(fileName string) string {
	code, _ := ioutil.ReadFile("./testdata/" + fileName)
	codeEncoded := hex.EncodeToString(code)
	return codeEncoded
}

func transferToken(processor process.TransactionProcessor, scAddress []byte, transferFunctionName string, from []byte, fromNonce *uint64, to []byte, amount uint64) error {
	txData := transferFunctionName + "@" + hex.EncodeToString(to) + "@" + strconv.FormatUint(amount, 16)

	tx := &transaction.Transaction{
		Nonce:    *fromNonce,
		Value:    big.NewInt(0),
		RcvAddr:  scAddress,
		SndAddr:  from,
		GasPrice: 1,
		GasLimit: 500000,
		Data:     txData,
	}

	err := processor.ProcessTransaction(tx, 444)
	*fromNonce++
	return err
}

func createInMemoryShardAccountsDB() *state.AccountsDB {
	marshalizer := &marshal.JsonMarshalizer{}
	store := createMemUnit()

	tr, _ := trie.NewTrie(store, marshalizer, hasher)
	adb, _ := state.NewAccountsDB(tr, hasher, marshalizer, &accountFactory{})

	return adb
}

func createMemUnit() storage.Storer {
	cache, _ := storageUnit.NewCache(storageUnit.LRUCache, 10, 1)
	persist, _ := memorydb.New()

	unit, _ := storageUnit.NewStorageUnit(cache, persist)
	return unit
}

func getBalance(accnts state.AccountsAdapter, scAddress []byte, accountAddress []byte) *big.Int {
	vmFactory, _ := shard.NewVMContainerFactory(accnts, addressConverter, math.MaxInt64, GasMap)
	vmContainer, _ := vmFactory.Create()

	service, _ := smartContract.NewSCQueryService(vmContainer)

	query := smartContract.SCQuery{
		ScAddress: scAddress,
		FuncName:  "do_balance",
		Arguments: []*big.Int{big.NewInt(0).SetBytes(accountAddress)},
	}

	vmOutput, _ := service.ExecuteQuery(&query)
	balance := vmOutput.ReturnData[0]
	return balance
}
