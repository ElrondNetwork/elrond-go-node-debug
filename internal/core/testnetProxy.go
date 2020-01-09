package core

import (
	"bytes"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"math/big"
	"net/http"

	"github.com/ElrondNetwork/elrond-go/crypto"
	"github.com/ElrondNetwork/elrond-go/crypto/signing/kyber/singlesig"
	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/ElrondNetwork/elrond-go/marshal"
)

type addressResource struct {
	Account *accountResource `json:"account"`
}

type accountResource struct {
	Address string `json:"address"`
	Nonce   uint64 `json:"nonce"`
}

func getNonce(nodeAPIUrl string, senderAddress []byte) (uint64, error) {
	senderAddressEncoded := hex.EncodeToString(senderAddress)
	url := fmt.Sprintf("%s/address/%s", nodeAPIUrl, senderAddressEncoded)
	log.Println("getNonce, perform GET:")
	log.Println(url)
	response, err := http.Get(url)
	if err != nil {
		return 0, err
	}

	defer response.Body.Close()
	body, _ := ioutil.ReadAll(response.Body)
	fmt.Println("Response:")
	fmt.Println(string(body))
	address := addressResource{}
	err = json.NewDecoder(bytes.NewBuffer(body)).Decode(&address)
	nonce := address.Account.Nonce
	fmt.Println("Nonce:")
	fmt.Println(nonce)
	return nonce, err
}

type sendTransactionResponse struct {
	Message string                          `json:"message"`
	Error   string                          `json:"error"`
	TxHash  string                          `json:"txHash,omitempty"`
	TxResp  *sendTransactionResponsePayload `json:"transaction,omitempty"`
}

type sendTransactionResponsePayload struct {
	Sender      string   `form:"sender" json:"sender"`
	Receiver    string   `form:"receiver" json:"receiver"`
	Value       *big.Int `form:"value" json:"value"`
	Data        string   `form:"data" json:"data"`
	Nonce       uint64   `form:"nonce" json:"nonce"`
	GasPrice    uint64   `form:"gasPrice" json:"gasPrice"`
	GasLimit    uint64   `form:"gasLimit" json:"gasLimit"`
	Signature   string   `form:"signature" json:"signature"`
	Challenge   string   `form:"challenge" json:"challenge"`
	ShardID     uint32   `json:"shardId"`
	Hash        string   `json:"hash"`
	BlockNumber uint64   `json:"blockNumber"`
	BlockHash   string   `json:"blockHash"`
	Timestamp   uint64   `json:"timestamp"`
}

func sendTransaction(nodeAPIUrl string, txBuff []byte) error {
	url := fmt.Sprintf("%s/transaction/send", nodeAPIUrl)
	log.Println("sendTransaction, perform POST:")
	log.Println(url)
	log.Println(string(txBuff))

	response, err := http.Post(url, "application/json", bytes.NewBuffer(txBuff))
	if err != nil {
		return err
	}

	defer response.Body.Close()
	body, _ := ioutil.ReadAll(response.Body)
	fmt.Println("Response:")
	fmt.Println(string(body))
	structuredResponse := sendTransactionResponse{}
	err = json.NewDecoder(bytes.NewBuffer(body)).Decode(&structuredResponse)
	return err
}

type jsonFriendlyTransaction struct {
	Nonce     uint64   `json:"nonce"`
	Value     *big.Int `json:"value"`
	Receiver  string   `json:"receiver"`
	Sender    string   `json:"sender"`
	GasPrice  uint64   `json:"gasPrice"`
	GasLimit  uint64   `json:"gasLimit"`
	Data      string   `json:"data"`
	Signature string   `json:"signature"`
}

func signAndStringifyTransaction(tx *transaction.Transaction, privateKey crypto.PrivateKey) []byte {
	txBuff, _ := marshal.JsonMarshalizer{}.Marshal(tx)
	signer := &singlesig.SchnorrSigner{}
	tx.Signature, _ = signer.Sign(privateKey, txBuff)

	jsonFriendlyTx := &jsonFriendlyTransaction{}
	jsonFriendlyTx.Nonce = tx.Nonce
	jsonFriendlyTx.Value = tx.Value
	jsonFriendlyTx.Receiver = hex.EncodeToString(tx.RcvAddr)
	jsonFriendlyTx.Sender = hex.EncodeToString(tx.SndAddr)
	jsonFriendlyTx.GasPrice = tx.GasPrice
	jsonFriendlyTx.GasLimit = tx.GasLimit
	jsonFriendlyTx.Data = string(tx.Data)
	jsonFriendlyTx.Signature = hex.EncodeToString(tx.Signature)

	jsonFriendlyTxBuff, _ := marshal.JsonMarshalizer{}.Marshal(jsonFriendlyTx)

	return jsonFriendlyTxBuff
}
