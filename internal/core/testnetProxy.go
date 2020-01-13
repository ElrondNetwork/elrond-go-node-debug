package core

import (
	"bytes"
	"encoding/base64"
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
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
)

type addressResource struct {
	Account *accountResource `json:"account"`
	Error   string           `json:"error"`
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
	body, err := ioutil.ReadAll(response.Body)
	if err != nil {
		return 0, err
	}

	fmt.Println("Response:")
	fmt.Println(string(body))
	address := addressResource{Account: &accountResource{}}
	err = json.NewDecoder(bytes.NewBuffer(body)).Decode(&address)
	if err != nil {
		return 0, err
	}
	if len(address.Error) > 0 {
		return 0, fmt.Errorf(address.Error)
	}

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

func sendTransaction(nodeAPIUrl string, txBuff []byte) (sendTransactionResponse, error) {
	url := fmt.Sprintf("%s/transaction/send", nodeAPIUrl)
	log.Println("sendTransaction, perform POST:")
	log.Println(url)
	log.Println(string(txBuff))

	response, err := http.Post(url, "application/json", bytes.NewBuffer(txBuff))
	if err != nil {
		return sendTransactionResponse{}, err
	}

	defer response.Body.Close()
	body, _ := ioutil.ReadAll(response.Body)
	fmt.Println("Response:")
	fmt.Println(string(body))
	structuredResponse := sendTransactionResponse{}
	err = json.NewDecoder(bytes.NewBuffer(body)).Decode(&structuredResponse)
	if err != nil {
		return sendTransactionResponse{}, err
	}
	if len(structuredResponse.Error) > 0 {
		return sendTransactionResponse{}, fmt.Errorf(structuredResponse.Error)
	}

	return structuredResponse, nil
}

type jsonFriendlyTransaction struct {
	Nonce     uint64 `json:"nonce"`
	Value     string `json:"value"`
	Receiver  string `json:"receiver"`
	Sender    string `json:"sender"`
	GasPrice  uint64 `json:"gasPrice"`
	GasLimit  uint64 `json:"gasLimit"`
	Data      string `json:"data"`
	Signature string `json:"signature"`
}

func signAndStringifyTransaction(tx *transaction.Transaction, privateKey crypto.PrivateKey) []byte {
	txBuff, _ := marshal.JsonMarshalizer{}.Marshal(tx)
	signer := &singlesig.SchnorrSigner{}
	tx.Signature, _ = signer.Sign(privateKey, txBuff)

	jsonFriendlyTx := &jsonFriendlyTransaction{}
	jsonFriendlyTx.Nonce = tx.Nonce
	jsonFriendlyTx.Value = tx.Value.String()
	jsonFriendlyTx.Receiver = hex.EncodeToString(tx.RcvAddr)
	jsonFriendlyTx.Sender = hex.EncodeToString(tx.SndAddr)
	jsonFriendlyTx.GasPrice = tx.GasPrice
	jsonFriendlyTx.GasLimit = tx.GasLimit
	jsonFriendlyTx.Data = base64.StdEncoding.EncodeToString(tx.Data)
	jsonFriendlyTx.Signature = hex.EncodeToString(tx.Signature)

	jsonFriendlyTxBuff, _ := marshal.JsonMarshalizer{}.Marshal(jsonFriendlyTx)

	return jsonFriendlyTxBuff
}

func querySC(nodeAPIUrl string, request VMValueRequest) (*vmcommon.VMOutput, error) {
	url := fmt.Sprintf("%s/vm-values/hex", nodeAPIUrl)

	queryBuff, _ := marshal.JsonMarshalizer{}.Marshal(request)
	log.Println("querySC, perform POST:")
	log.Println(url)
	log.Println(string(queryBuff))

	response, err := http.Post(url, "application/json", bytes.NewBuffer(queryBuff))
	if err != nil {
		return nil, err
	}

	defer response.Body.Close()
	body, _ := ioutil.ReadAll(response.Body)
	fmt.Println("Response:")
	fmt.Println(string(body))
	structuredResponse := vmcommon.VMOutput{}
	err = json.NewDecoder(bytes.NewBuffer(body)).Decode(&structuredResponse)
	if err != nil {
		return nil, err
	}

	return &structuredResponse, nil
}
