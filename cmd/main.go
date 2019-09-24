package cmd

import (
	"encoding/hex"
	"fmt"
	"io/ioutil"
	"math/big"
	"os"

	"github.com/ElrondNetwork/elrond-go-node-debug/process"
	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/ElrondNetwork/elrond-go/process/factory"
)

func main() {
	argsWithoutProg := os.Args[1:]
	if len(argsWithoutProg) < 1 {
		fmt.Println("not enough arguments to debug smart contract")
		return
	}

	fmt.Println("arguments ", argsWithoutProg)

	ownerAddressBytes := []byte("12345678901234567890123456789012")
	ownerNonce := uint64(0)
	ownerBalance := big.NewInt(100000000)
	round := uint64(1)
	gasPrice := uint64(1)
	gasLimit := uint64(100000)
	transferOnCalls := big.NewInt(5)

	scCode, err := ioutil.ReadFile("./wrc20_arwen.wasm")
	if err != nil {
		fmt.Println("Error on reading wasm file " + argsWithoutProg[0] + " " + err.Error())
		return
	}

	scCodeString := hex.EncodeToString(scCode)

	tx := &transaction.Transaction{
		Nonce:     ownerNonce,
		Value:     transferOnCalls,
		RcvAddr:   process.CreateEmptyAddress().Bytes(),
		SndAddr:   ownerAddressBytes,
		GasPrice:  gasPrice,
		GasLimit:  gasLimit,
		Data:      scCodeString + "@" + hex.EncodeToString(factory.ArwenVirtualMachine),
		Signature: nil,
		Challenge: nil,
	}

	txProc, accnts, blockchainHook := process.CreatePreparedTxProcessorAndAccountsWithVMs(ownerNonce, ownerAddressBytes, ownerBalance)

	err = txProc.ProcessTransaction(tx, round)
	if err != nil {
		fmt.Println("Error while deploying the smart contract " + err.Error())
	}

	_, err = accnts.Commit()
	if err != nil {
		fmt.Println("Error while state commit " + err.Error())
	}

	if len(argsWithoutProg) < 2 {
		return
	}

	scAddress, err := blockchainHook.NewAddress(ownerAddressBytes, ownerNonce, factory.ArwenVirtualMachine)
	if err != nil {
		fmt.Println("Error creating smart contract address")
		return
	}

	alice := []byte("12345678901234567890123456789111")
	aliceNonce := uint64(0)
	_ = process.CreateAccount(accnts, alice, aliceNonce, big.NewInt(1000000))

	txData := argsWithoutProg[1]
	for i := 2; i < len(argsWithoutProg); i++ {
		txData += "@" + hex.EncodeToString([]byte(argsWithoutProg[i]))
	}

	tx = &transaction.Transaction{
		Nonce:     aliceNonce,
		Value:     transferOnCalls,
		RcvAddr:   scAddress,
		SndAddr:   alice,
		GasPrice:  gasPrice,
		GasLimit:  gasLimit,
		Data:      txData,
		Signature: nil,
		Challenge: nil,
	}

	err = txProc.ProcessTransaction(tx, round)
	if err != nil {
		fmt.Println("Error while running the smart contract " + err.Error())
	}

	_, err = accnts.Commit()
	if err != nil {
		fmt.Println("Error while state commit " + err.Error())
	}
}
