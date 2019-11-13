package core

import (
	"encoding/hex"
	"fmt"
	"io/ioutil"
	"math"
	"math/big"
	"testing"
	"time"

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
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
	"github.com/stretchr/testify/assert"
)

func TestVmDeployWithTransferAndExecuteERC20(t *testing.T) {
	ownerAddressBytes := []byte("12345678901234567890123456789012")
	ownerNonce := uint64(11)
	ownerBalance := big.NewInt(100000000)
	round := uint64(444)
	gasPrice := uint64(1)
	gasLimit := uint64(100000)
	transferOnCalls := big.NewInt(5)

	scCode, err := ioutil.ReadFile("./testdata/wrc20_arwen.wasm")
	assert.Nil(t, err)

	scCodeString := hex.EncodeToString(scCode)

	tx := &transaction.Transaction{
		Nonce:     ownerNonce,
		Value:     transferOnCalls,
		RcvAddr:   CreateEmptyAddress().Bytes(),
		SndAddr:   ownerAddressBytes,
		GasPrice:  gasPrice,
		GasLimit:  gasLimit,
		Data:      scCodeString + "@" + hex.EncodeToString(factory.ArwenVirtualMachine),
		Signature: nil,
		Challenge: nil,
	}

	txProc, accnts, blockchainHook := createPreparedTxProcessorAndAccountsWithVMs(ownerNonce, ownerAddressBytes, ownerBalance)

	err = txProc.ProcessTransaction(tx, round)
	assert.Nil(t, err)

	_, err = accnts.Commit()
	assert.Nil(t, err)

	scAddress, _ := blockchainHook.NewAddress(ownerAddressBytes, ownerNonce, factory.ArwenVirtualMachine)

	alice := []byte("12345678901234567890123456789111")
	aliceNonce := uint64(0)
	_ = CreateAccount(accnts, alice, aliceNonce, big.NewInt(1000000))

	bob := []byte("12345678901234567890123456789222")
	_ = CreateAccount(accnts, bob, 0, big.NewInt(1000000))

	initAlice := big.NewInt(100000)
	tx = &transaction.Transaction{
		Nonce:     aliceNonce,
		Value:     initAlice,
		RcvAddr:   scAddress,
		SndAddr:   alice,
		GasPrice:  0,
		GasLimit:  5000,
		Data:      "topUp",
		Signature: nil,
		Challenge: nil,
	}
	start := time.Now()
	err = txProc.ProcessTransaction(tx, round)
	elapsedTime := time.Since(start)
	fmt.Printf("time elapsed to process topup %s \n", elapsedTime.String())
	assert.Nil(t, err)

	_, err = accnts.Commit()
	assert.Nil(t, err)

	aliceNonce++

	start = time.Now()
	nrTxs := 10

	for i := 0; i < nrTxs; i++ {
		tx = &transaction.Transaction{
			Nonce:     aliceNonce,
			Value:     big.NewInt(0),
			RcvAddr:   scAddress,
			SndAddr:   alice,
			GasPrice:  0,
			GasLimit:  5000,
			Data:      "transfer@" + hex.EncodeToString(bob) + "@" + transferOnCalls.String(),
			Signature: nil,
			Challenge: nil,
		}

		err = txProc.ProcessTransaction(tx, round)
		assert.Nil(t, err)

		aliceNonce++
	}

	_, err = accnts.Commit()
	assert.Nil(t, err)

	elapsedTime = time.Since(start)
	fmt.Printf("time elapsed to process %d ERC20 transfers %s \n", nrTxs, elapsedTime.String())

	finalAlice := big.NewInt(0).Sub(initAlice, big.NewInt(int64(nrTxs)*transferOnCalls.Int64()))
	assert.Equal(t, finalAlice.Uint64(), getBalance(accnts, scAddress, alice).Uint64())
	finalBob := big.NewInt(int64(nrTxs) * transferOnCalls.Int64())
	assert.Equal(t, finalBob.Uint64(), getBalance(accnts, scAddress, bob).Uint64())
}

func createPreparedTxProcessorAndAccountsWithVMs(senderNonce uint64, senderAddressBytes []byte, senderBalance *big.Int) (process.TransactionProcessor, state.AccountsAdapter, vmcommon.BlockchainHook) {

	accnts := createInMemoryShardAccountsDB()
	_ = CreateAccount(accnts, senderAddressBytes, senderNonce, senderBalance)

	txProcessor, blockchainHook := CreateTxProcessorWithOneSCExecutorWithVMs(accnts)

	return txProcessor, accnts, blockchainHook
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
