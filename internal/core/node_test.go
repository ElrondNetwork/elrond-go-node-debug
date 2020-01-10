package core

import (
	"encoding/hex"
	"io/ioutil"
	"math/big"
	"testing"

	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/ElrondNetwork/elrond-go/data/trie"
	"github.com/ElrondNetwork/elrond-go/marshal"
	"github.com/ElrondNetwork/elrond-go/process"
	"github.com/ElrondNetwork/elrond-go/process/factory"
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

func Test_C_ERC20(t *testing.T) {
	context := setupTestContext(t)
	smartContractCode := getSmartContractCode("./testdata/wrc20_arwen_c.wasm")

	scAddress, _, err := context.Node.DeploySmartContract(DeploySmartContractCommand{
		SndAddress: context.OwnerAddress,
		Value:      "0",
		GasPrice:   1,
		GasLimit:   500000,
		TxData:     smartContractCode + "@" + hex.EncodeToString(factory.ArwenVirtualMachine) + "@" + formatHexNumber(5000),
	})

	assert.Nil(t, err)

	_, err = context.Node.RunSmartContract(RunSmartContractCommand{
		ScAddress:  scAddress,
		SndAddress: context.OwnerAddress,
		Value:      "0",
		GasPrice:   1,
		GasLimit:   500000,
		TxData:     "transferToken@" + hex.EncodeToString(context.AliceAddress) + "@" + formatHexNumber(1000),
	})

	_, err = context.Node.RunSmartContract(RunSmartContractCommand{
		ScAddress:  scAddress,
		SndAddress: context.AliceAddress,
		Value:      "0",
		GasPrice:   1,
		GasLimit:   500000,
		TxData:     "transferToken@" + hex.EncodeToString(context.BobAddress) + "@" + formatHexNumber(500),
	})

	assert.Nil(t, err)

	assert.Equal(t, uint64(4000), getBalance(&context, scAddress, "balanceOf", context.OwnerAddress).Uint64())
	assert.Equal(t, uint64(500), getBalance(&context, scAddress, "balanceOf", context.AliceAddress).Uint64())
	assert.Equal(t, uint64(500), getBalance(&context, scAddress, "balanceOf", context.BobAddress).Uint64())
}

func Test_SOL_ERC20_0_0_3(t *testing.T) {
	context := setupTestContext(t)
	smartContractCode := getSmartContractCode("./testdata/0-0-3_sol.wasm")

	scAddress, _, err := context.Node.DeploySmartContract(DeploySmartContractCommand{
		SndAddress: context.OwnerAddress,
		Value:      "0",
		GasPrice:   1,
		GasLimit:   500000,
		TxData:     smartContractCode + "@" + hex.EncodeToString(factory.ArwenVirtualMachine),
	})

	assert.Nil(t, err)
	context.OwnerNonce++

	assert.Equal(t, uint64(100000000), getBalance(&context, scAddress, "balanceOf(address)", context.OwnerAddress).Uint64())

	transferToken(t, &context, scAddress, "transfer(address,uint256)", context.OwnerAddress, &context.OwnerNonce, context.AliceAddress, 500)
	assert.Equal(t, uint64(500), getBalance(&context, scAddress, "balanceOf(address)", context.AliceAddress).Uint64())
}

func Test_NoPanic_WhenBadCode(t *testing.T) {
	context := setupTestContext(t)

	_, _, _ = context.Node.DeploySmartContract(DeploySmartContractCommand{
		SndAddress: context.OwnerAddress,
		Value:      "0",
		GasPrice:   1,
		GasLimit:   500000,
		TxData:     "123456" + "@" + hex.EncodeToString(factory.ArwenVirtualMachine),
	})
}

func Test_NoPanic_SOL_WhenBadFunction(t *testing.T) {
	context := setupTestContext(t)
	smartContractCode := getSmartContractCode("./testdata/0-0-3_sol.wasm")

	scAddress, _, err := context.Node.DeploySmartContract(DeploySmartContractCommand{
		SndAddress: context.OwnerAddress,
		Value:      "0",
		GasPrice:   1,
		GasLimit:   500000,
		TxData:     smartContractCode + "@" + hex.EncodeToString(factory.ArwenVirtualMachine),
	})

	assert.Nil(t, err)
	context.OwnerNonce++

	_, _ = context.Node.RunSmartContract(RunSmartContractCommand{
		ScAddress:  scAddress,
		SndAddress: context.OwnerAddress,
		Value:      "0",
		GasPrice:   1,
		GasLimit:   500000,
		TxData:     "badFunction@0000@0000",
	})

	_, _ = context.Node.RunSmartContract(RunSmartContractCommand{
		ScAddress:  scAddress,
		SndAddress: context.OwnerAddress,
		Value:      "0",
		GasPrice:   1,
		GasLimit:   500000,
		TxData:     "@",
	})
}

func Test_NoPanic_SOL_WhenBadArgumens(t *testing.T) {
	context := setupTestContext(t)
	smartContractCode := getSmartContractCode("./testdata/0-0-3_sol.wasm")

	scAddress, _, err := context.Node.DeploySmartContract(DeploySmartContractCommand{
		SndAddress: context.OwnerAddress,
		Value:      "0",
		GasPrice:   1,
		GasLimit:   500000,
		TxData:     smartContractCode + "@" + hex.EncodeToString(factory.ArwenVirtualMachine),
	})

	assert.Nil(t, err)
	context.OwnerNonce++

	_, err = context.Node.RunSmartContract(RunSmartContractCommand{
		ScAddress:  scAddress,
		SndAddress: context.OwnerAddress,
		Value:      "0",
		GasPrice:   1,
		GasLimit:   500000,
		TxData:     "transfer(address,uint256)@0000@1000",
	})
}

func setupTestContext(t *testing.T) testContext {
	context := testContext{}

	context.OwnerAddress = []byte{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o', 'o'}
	context.OwnerNonce = uint64(1)
	context.OwnerBalance = big.NewInt(100000000)
	context.AliceAddress = []byte{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a', 'a'}
	context.AliceNonce = uint64(1)
	context.AliceBalance = big.NewInt(1000000)
	context.BobAddress = []byte{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b'}
	context.BobNonce = uint64(1)
	context.BobBalance = big.NewInt(1000000)

	accounts := createInMemoryShardAccountsDB()
	_ = CreateAccount(accounts, context.OwnerAddress, context.OwnerNonce, context.OwnerBalance)
	_ = CreateAccount(accounts, context.AliceAddress, context.AliceNonce, context.AliceBalance)
	_ = CreateAccount(accounts, context.BobAddress, context.BobNonce, context.BobBalance)

	node, err := NewSimpleDebugNode(accounts)
	assert.Nil(t, err)
	assert.NotNil(t, node)

	context.Accounts = accounts
	context.Node = node

	return context
}

func getSmartContractCode(fileName string) string {
	code, _ := ioutil.ReadFile(fileName)
	codeEncoded := hex.EncodeToString(code)
	return codeEncoded
}

func transferToken(t *testing.T, context *testContext, scAddress []byte, transferFunctionName string, from []byte, fromNonce *uint64, to []byte, amount uint64) {
	txData := transferFunctionName + "@" + hex.EncodeToString(to) + "@" + formatHexNumber(amount)

	tx := &transaction.Transaction{
		Nonce:    *fromNonce,
		Value:    big.NewInt(0),
		RcvAddr:  scAddress,
		SndAddr:  from,
		GasPrice: 1,
		GasLimit: 500000,
		Data:     []byte(txData),
	}

	err := context.Node.TxProcessor.ProcessTransaction(tx)
	assert.Nil(t, err)
	*fromNonce++
}

func createInMemoryShardAccountsDB() *state.AccountsDB {
	marshalizer := &marshal.JsonMarshalizer{}
	store := createMemUnit()

	tr, _ := trie.NewTrie(store, marshalizer, Hasher)
	adb, _ := state.NewAccountsDB(tr, Hasher, marshalizer, &accountFactory{})

	return adb
}

func getBalance(context *testContext, scAddress []byte, balanceFunctionName string, accountAddress []byte) *big.Int {
	query := process.SCQuery{
		ScAddress: scAddress,
		FuncName:  balanceFunctionName,
		Arguments: [][]byte{accountAddress},
	}

	vmOutput, _ := context.Node.SCQueryService.ExecuteQuery(&query)
	balanceBytes := vmOutput.ReturnData[0]
	balance := big.NewInt(0).SetBytes(balanceBytes)
	return balance
}

func formatHexNumber(number uint64) string {
	bytes := big.NewInt(0).SetUint64(number).Bytes()
	bytes32 := make([]byte, 32)
	copy(bytes32[32-len(bytes):], bytes)
	str := hex.EncodeToString(bytes32)
	return str
}
