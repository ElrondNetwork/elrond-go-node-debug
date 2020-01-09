package core

import (
	"math/big"
	"testing"

	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/stretchr/testify/require"
)

func Test_GetNonce(t *testing.T) {
	url := ""
	address := []byte{}
	nonce, err := getNonce(url, address)

	require.Nil(t, err)
	require.GreaterOrEqual(t, 0, nonce)
}

func Test_SendTransaction(t *testing.T) {
	url := ""
	pemString := ""
	scAddress := []byte{}

	privateKey, err := readPrivateKeyFromPemText(pemString)
	require.Nil(t, err)
	publicKey, err := privateKey.GeneratePublic().ToByteArray()
	require.Nil(t, err)
	nonce, err := getNonce(url, publicKey)
	require.Nil(t, err)

	tx := &transaction.Transaction{
		Nonce:    nonce,
		Value:    big.NewInt(0),
		RcvAddr:  scAddress,
		SndAddr:  publicKey,
		GasPrice: 10,
		GasLimit: 50000,
		Data:     []byte("test"),
	}

	txBuff := signAndStringifyTransaction(tx, privateKey)
	response, err := sendTransaction(url, txBuff)

	require.Nil(t, err)
	require.NotNil(t, response)
}
