package integrationtests

import (
	"encoding/hex"
	"io/ioutil"
	"math/big"
	"testing"

	"github.com/ElrondNetwork/elrond-go-node-debug/internal/shared"
	"github.com/ElrondNetwork/elrond-go-node-debug/internal/testnet"
	"github.com/ElrondNetwork/elrond-go/crypto"
	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/stretchr/testify/require"
)

const proxyURL = "http://127.0.0.1:8001"

func TestProxy_GetNonce(t *testing.T) {
	proxy := testnet.NewProxy(proxyURL)
	owner := getOwnerAddressAsBytes()
	nonce, err := proxy.GetNonce(owner)
	require.Nil(t, err)
	require.GreaterOrEqual(t, nonce, uint64(0))
}

func TestProxy_SendTransactionShouldWork(t *testing.T) {
	proxy := testnet.NewProxy(proxyURL)
	owner := getOwnerAddressAsBytes()
	privateKey := getOwnerPrivateKey()
	nonce, err := proxy.GetNonce(owner)
	require.Nil(t, err)

	tx := &transaction.Transaction{
		Nonce:    nonce,
		Value:    big.NewInt(0),
		RcvAddr:  shared.CreateEmptyAddress().Bytes(),
		SndAddr:  owner,
		GasPrice: 100000000000000,
		GasLimit: 500000,
		Data:     []byte("test"),
	}

	signedTransaction, err := shared.NewSignedTransaction(tx, privateKey)
	require.Nil(t, err)
	response, err := proxy.SendTransaction(signedTransaction.Bytes)
	require.Nil(t, err)
	require.NotNil(t, response)
}

func TestProxy_SendTransactionSmallGasPriceShouldErr(t *testing.T) {
	proxy := testnet.NewProxy(proxyURL)
	owner := getOwnerAddressAsBytes()
	privateKey := getOwnerPrivateKey()
	nonce, err := proxy.GetNonce(owner)
	require.Nil(t, err)

	tx := &transaction.Transaction{
		Nonce:    nonce,
		Value:    big.NewInt(0),
		RcvAddr:  shared.CreateEmptyAddress().Bytes(),
		SndAddr:  owner,
		GasPrice: 42,
		GasLimit: 500000,
		Data:     []byte("test"),
	}

	signedTransaction, err := shared.NewSignedTransaction(tx, privateKey)
	require.Nil(t, err)
	response, err := proxy.SendTransaction(signedTransaction.Bytes)
	require.Errorf(t, err, "insufficient gas price")
	require.Nil(t, response)
}

func TestProxy_QueryVariableInvalidContractAddressShouldErr(t *testing.T) {
	proxy := testnet.NewProxy(proxyURL)

	vmOutput, err := proxy.QuerySC(testnet.SCQueryRequest{
		ScAddress: "00000000000000000500086444727b33581181388f6d62a3b3114feeaaaaaaaa",
		FuncName:  "balanceOf",
		Args:      []string{getOwnerAddress()},
	})

	require.Errorf(t, err, "contract invalid")
	require.Nil(t, vmOutput)
}

func getOwnerAddress() string {
	return "8eb27b2bcaedc6de11793cf0625a4f8d64bf7ac84753a0b6c5d6ceb2be7eb39d"
}

func getOwnerAddressAsBytes() []byte {
	bytes, _ := hex.DecodeString(getOwnerAddress())
	return bytes
}

func getOwnerPrivateKey() crypto.PrivateKey {
	pemString, err := ioutil.ReadFile("./testdata/privateKey.pem")
	if err != nil {
		panic(err)
	}

	privateKey, err := shared.ReadPrivateKeyFromPemText(string(pemString))
	if err != nil {
		panic(err)
	}

	return privateKey
}

func getPemString() string {
	pemString, err := ioutil.ReadFile("./testdata/privateKey.pem")
	if err != nil {
		panic(err)
	}

	return string(pemString)
}
