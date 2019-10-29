package process

import (
	"encoding/hex"
	"fmt"
	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/ElrondNetwork/elrond-go/process/factory"
	"github.com/stretchr/testify/assert"
	"io/ioutil"
	"math/big"
	"testing"
	"time"
)

func TestVmDeployWithTransferAndExecuteERC20(t *testing.T) {
	ownerAddressBytes, _ := hex.DecodeString("1234123400000000000000000000000000000000000000000000000000000000")
	ownerNonce := uint64(11)
	ownerBalance := big.NewInt(100000000)
	round := uint64(444)
	gasPrice := uint64(1)
	gasLimit := uint64(100000)
	transferOnCalls := big.NewInt(5)

	scCode, err := ioutil.ReadFile("./wrc20_arwen.wasm")
	assert.Nil(t, err)

	scCodeString := hex.EncodeToString(scCode)

	tx := &transaction.Transaction{
		Nonce:     ownerNonce,
		Value:     big.NewInt(0),
		RcvAddr:   CreateEmptyAddress().Bytes(),
		SndAddr:   ownerAddressBytes,
		GasPrice:  gasPrice,
		GasLimit:  gasLimit,
		Data:      scCodeString + "@" + hex.EncodeToString(factory.ArwenVirtualMachine) + "@100000000",
		Signature: nil,
		Challenge: nil,
	}

	txProc, accnts, blockchainHook := CreatePreparedTxProcessorAndAccountsWithVMs(ownerNonce, ownerAddressBytes, ownerBalance)

	err = txProc.ProcessTransaction(tx, round)
	assert.Nil(t, err)

	_, err = accnts.Commit()
	assert.Nil(t, err)

	scAddress, _ := blockchainHook.NewAddress(ownerAddressBytes, ownerNonce, factory.ArwenVirtualMachine)

	alice, _ := hex.DecodeString("aaaaaaaaa0000000000000000000000000000000000000000000000000000000")
	aliceNonce := uint64(0)
	_ = CreateAccount(accnts, alice, aliceNonce, big.NewInt(1000000))

	bob, _ := hex.DecodeString("bbbbbbbbb0000000000000000000000000000000000000000000000000000000")
	_ = CreateAccount(accnts, bob, 0, big.NewInt(1000000))

	ownerNonce++
	initAlice := big.NewInt(100000)
	tx = &transaction.Transaction{
		Nonce:     ownerNonce,
		Value:     big.NewInt(0),
		RcvAddr:   scAddress,
		SndAddr:   ownerAddressBytes,
		GasPrice:  0,
		GasLimit:  5000,
		Data:      "transfer_token@" + hex.EncodeToString(alice) + "@" + initAlice.Text(16),
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

	start = time.Now()
	nrTxs := 1000

	for i := 0; i < nrTxs; i++ {
		tx = &transaction.Transaction{
			Nonce:     aliceNonce,
			Value:     big.NewInt(0),
			RcvAddr:   scAddress,
			SndAddr:   alice,
			GasPrice:  0,
			GasLimit:  5000,
			Data:      "transfer_token@" + hex.EncodeToString(bob) + "@" + transferOnCalls.String(),
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
	assert.Equal(t, finalAlice.Uint64(), GetIntValueFromSC(accnts, scAddress, "do_balance", alice).Uint64())
	finalBob := big.NewInt(int64(nrTxs) * transferOnCalls.Int64())
	assert.Equal(t, finalBob.Uint64(), GetIntValueFromSC(accnts, scAddress, "do_balance", bob).Uint64())
}
