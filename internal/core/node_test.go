package core

import (
	"encoding/hex"
	"io/ioutil"
	"math/big"
	"strconv"
	"testing"

	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/ElrondNetwork/elrond-go/data/trie"
	"github.com/ElrondNetwork/elrond-go/marshal"
	"github.com/ElrondNetwork/elrond-go/process/factory"
	"github.com/ElrondNetwork/elrond-go/process/smartContract"
	"github.com/ElrondNetwork/elrond-go/storage"
	"github.com/ElrondNetwork/elrond-go/storage/memorydb"
	"github.com/ElrondNetwork/elrond-go/storage/storageUnit"
	"github.com/stretchr/testify/assert"
)

type testContext struct {
	OwnerAddress []byte
	OwnerNonce   uint64
	OwnerBalance *big.Int
	AliceAddress []byte
	AliceNonce   uint64
	AliceBalance *big.Int
	BobAddress   []byte
	BobNonce     uint64
	BobBalance   *big.Int
	Accounts     *state.AccountsDB
	Node         *SimpleDebugNode
}

func TestER20_C_Old(t *testing.T) {
	context := setupTestContext(t)
	transferOnCalls := big.NewInt(5)
	aliceInit := big.NewInt(100000)
	smartContractCode := getSmartContractCode("wrc20_arwen_c_old.wasm")

	tx := &transaction.Transaction{
		Nonce:     context.OwnerNonce,
		Value:     big.NewInt(0),
		RcvAddr:   CreateEmptyAddress().Bytes(),
		SndAddr:   context.OwnerAddress,
		GasPrice:  1,
		GasLimit:  500000,
		Data:      smartContractCode + "@" + hex.EncodeToString(factory.ArwenVirtualMachine),
		Signature: nil,
		Challenge: nil,
	}

	err := context.Node.TxProcessor.ProcessTransaction(tx, DefaultRound)
	assert.Nil(t, err)

	_, err = context.Accounts.Commit()
	assert.Nil(t, err)

	scAddress, _ := context.Node.BlockChainHook.NewAddress(context.OwnerAddress, context.OwnerNonce, factory.ArwenVirtualMachine)

	tx = &transaction.Transaction{
		Nonce:    context.AliceNonce,
		Value:    aliceInit,
		RcvAddr:  scAddress,
		SndAddr:  context.AliceAddress,
		GasPrice: 1,
		GasLimit: 500000,
		Data:     "topUp",
	}

	err = context.Node.TxProcessor.ProcessTransaction(tx, DefaultRound)
	assert.Nil(t, err)

	_, err = context.Accounts.Commit()
	assert.Nil(t, err)

	context.AliceNonce++

	nrTxs := 10

	for i := 0; i < nrTxs; i++ {
		transferToken(&context, scAddress, "transfer", context.AliceAddress, &context.AliceNonce, context.BobAddress, 5)
	}

	_, err = context.Accounts.Commit()
	assert.Nil(t, err)

	finalAlice := big.NewInt(0).Sub(aliceInit, big.NewInt(int64(nrTxs)*transferOnCalls.Int64()))
	assert.Equal(t, finalAlice.Uint64(), getBalance(&context, scAddress, "do_balance", context.AliceAddress).Uint64())
	finalBob := big.NewInt(int64(nrTxs) * transferOnCalls.Int64())
	assert.Equal(t, finalBob.Uint64(), getBalance(&context, scAddress, "do_balance", context.BobAddress).Uint64())
}

func TestER20_C_New(t *testing.T) {
	context := setupTestContext(t)
	smartContractCode := getSmartContractCode("wrc20_arwen_c.wasm")

	scAddress, err := context.Node.DeploySmartContract(DeploySmartContractCommand{
		SndAddress: context.OwnerAddress,
		Value:      "5000",
		GasPrice:   1,
		GasLimit:   500000,
		TxData:     smartContractCode + "@" + hex.EncodeToString(factory.ArwenVirtualMachine),
	})

	assert.Nil(t, err)

	_, err = context.Node.RunSmartContract(RunSmartContractCommand{
		ScAddress:  scAddress,
		SndAddress: context.OwnerAddress,
		Value:      "0",
		GasPrice:   1,
		GasLimit:   500000,
		TxData:     "transferToken@" + hex.EncodeToString(context.AliceAddress) + "@" + strconv.FormatUint(500, 16),
	})

	assert.Nil(t, err)

	assert.Equal(t, uint64(500), getBalance(&context, scAddress, "balanceOf", context.AliceAddress).Uint64())
}

func Test_0_0_3_SOL(t *testing.T) {
	context := setupTestContext(t)
	smartContractCode := getSmartContractCode("0-0-3_sol.wasm")

	tx := &transaction.Transaction{
		Nonce:     context.OwnerNonce,
		Value:     big.NewInt(0),
		RcvAddr:   CreateEmptyAddress().Bytes(),
		SndAddr:   context.OwnerAddress,
		GasPrice:  1,
		GasLimit:  500000,
		Data:      smartContractCode + "@" + hex.EncodeToString(factory.ArwenVirtualMachine),
		Signature: nil,
		Challenge: nil,
	}

	err := context.Node.TxProcessor.ProcessTransaction(tx, DefaultRound)
	assert.Nil(t, err)

	_, err = context.Accounts.Commit()
	assert.Nil(t, err)

	scAddress, _ := context.Node.BlockChainHook.NewAddress(context.OwnerAddress, context.OwnerNonce, factory.ArwenVirtualMachine)

	transferToken(&context, scAddress, "transfer(address,uint256)", context.OwnerAddress, &context.OwnerNonce, context.AliceAddress, 500)

	_, err = context.Accounts.Commit()
	assert.Nil(t, err)

	assert.Equal(t, uint64(500), getBalance(&context, scAddress, "balanceOf(address)", context.AliceAddress).Uint64())
}

func setupTestContext(t *testing.T) testContext {
	context := testContext{}

	context.OwnerAddress = []byte("12345678901234567890123456789012")
	context.OwnerNonce = uint64(1)
	context.OwnerBalance = big.NewInt(100000000)
	context.AliceAddress = []byte("12345678901234567890123456789111")
	context.AliceNonce = uint64(1)
	context.AliceBalance = big.NewInt(1000000)
	context.BobAddress = []byte("12345678901234567890123456789222")
	context.BobNonce = uint64(1)
	context.BobBalance = big.NewInt(1000000)

	accounts := createInMemoryShardAccountsDB()
	_ = CreateAccount(accounts, context.OwnerAddress, context.OwnerNonce, context.OwnerBalance)
	_ = CreateAccount(accounts, context.AliceAddress, context.AliceNonce, context.AliceBalance)
	_ = CreateAccount(accounts, context.BobAddress, context.BobNonce, context.BobBalance)

	node, err := NewSimpleDebugNode(accounts)
	assert.Nil(t, err)

	context.Accounts = accounts
	context.Node = node

	return context
}

func getSmartContractCode(fileName string) string {
	code, _ := ioutil.ReadFile("./testdata/" + fileName)
	codeEncoded := hex.EncodeToString(code)
	return codeEncoded
}

func transferToken(context *testContext, scAddress []byte, transferFunctionName string, from []byte, fromNonce *uint64, to []byte, amount uint64) error {
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

	err := context.Node.TxProcessor.ProcessTransaction(tx, DefaultRound)
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

func getBalance(context *testContext, scAddress []byte, balanceFunctionName string, accountAddress []byte) *big.Int {
	query := smartContract.SCQuery{
		ScAddress: scAddress,
		FuncName:  balanceFunctionName,
		Arguments: []*big.Int{big.NewInt(0).SetBytes(accountAddress)},
	}

	vmOutput, _ := context.Node.SCQueryService.ExecuteQuery(&query)
	balance := vmOutput.ReturnData[0]
	return balance
}
