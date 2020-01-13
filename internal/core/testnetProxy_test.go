package core

import (
	"encoding/hex"
	"io/ioutil"
	"math/big"
	"testing"

	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/stretchr/testify/require"
)

const proxyURL = "http://127.0.0.1:8001"
const ownerAddress = "8eb27b2bcaedc6de11793cf0625a4f8d64bf7ac84753a0b6c5d6ceb2be7eb39d"

func Test_GetNonce(t *testing.T) {
	address, _ := hex.DecodeString(ownerAddress)
	nonce, err := getNonce(proxyURL, address)
	require.Nil(t, err)
	require.GreaterOrEqual(t, nonce, uint64(0))
}

func Test_SendDeployTransaction(t *testing.T) {
	privateKey, err := readPrivateKeyFromPemText(getPemString())
	require.Nil(t, err)
	publicKey, err := privateKey.GeneratePublic().ToByteArray()
	require.Nil(t, err)
	nonce, err := getNonce(proxyURL, publicKey)
	require.Nil(t, err)
	tx := &transaction.Transaction{
		Nonce:    nonce,
		Value:    big.NewInt(0),
		RcvAddr:  CreateEmptyAddress().Bytes(),
		SndAddr:  publicKey,
		GasPrice: 100000000000000,
		GasLimit: 500000,
		Data:     []byte("test"),
	}
	txBuff := signAndStringifyTransaction(tx, privateKey)
	response, err := sendTransaction(proxyURL, txBuff)
	require.Nil(t, err)
	require.NotNil(t, response)
}

func Test_QueryVariable(t *testing.T) {

}

func getPemString() string {
	pemString, _ := ioutil.ReadFile("./testdata/test.pem")
	return string(pemString)
}
