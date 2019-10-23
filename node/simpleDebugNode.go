package node

import (
	"bytes"
	"encoding/hex"
	"encoding/json"
	"encoding/pem"
	"errors"
	"fmt"
	"log"
	"math/big"
	"net/http"

	debugInit "github.com/ElrondNetwork/elrond-go-node-debug/process"
	"github.com/ElrondNetwork/elrond-go/crypto"
	"github.com/ElrondNetwork/elrond-go/crypto/signing"
	"github.com/ElrondNetwork/elrond-go/crypto/signing/kyber"
	"github.com/ElrondNetwork/elrond-go/crypto/signing/kyber/singlesig"
	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/state/addressConverters"
	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/ElrondNetwork/elrond-go/marshal"
	"github.com/ElrondNetwork/elrond-go/process"
	"github.com/ElrondNetwork/elrond-go/process/factory"
	"github.com/ElrondNetwork/elrond-go/sharding"
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
)

// ProcessSmartContract is the interface that holds functions for processing smart contracts.
type ProcessSmartContract interface {
	DeploySmartContract(command DeploySmartContractCommand) ([]byte, error)
	RunSmartContract(command RunSmartContractCommand) ([]byte, error)
	IsInterfaceNil() bool
}

// DeploySmartContractCommand represents the command for deploying a smart contract.
type DeploySmartContractCommand struct {
	OnTestnet           bool
	PrivateKey          string
	TestnetNodeEndpoint string
	SndAddressEncoded   string
	SndAddress          []byte
	Code                string
	ArgsBuff            [][]byte
}

// RunSmartContractCommand represents the command for running a smart contract.
type RunSmartContractCommand struct {
	OnTestnet           bool
	PrivateKey          string
	TestnetNodeEndpoint string
	SndAddressEncoded   string
	SndAddress          []byte
	ScAddress           string
	Value               string
	GasPrice            uint64
	GasLimit            uint64
	FuncName            string
	FuncArgsBuff        [][]byte
}

type SimpleDebugNode struct {
	acnts          state.AccountsAdapter
	txProcessor    process.TransactionProcessor
	blockChainHook vmcommon.BlockchainHook
	addrConverter  state.AddressConverter
}

func NewSimpleDebugNode(accnts state.AccountsAdapter, genesisFile string) (*SimpleDebugNode, error) {
	genesisConfig, err := sharding.NewGenesisConfig(genesisFile)
	if err != nil {
		return nil, err
	}

	if accnts == nil || accnts.IsInterfaceNil() {
		return nil, errors.New("nil accounts adapter")
	}

	node := &SimpleDebugNode{
		acnts:          accnts,
		txProcessor:    nil,
		blockChainHook: nil,
	}

	shardC, err := sharding.NewMultiShardCoordinator(1, 0)
	if err != nil {
		return nil, err
	}

	node.addrConverter, err = addressConverters.NewPlainAddressConverter(32, "0x")
	if err != nil {
		return nil, err
	}

	mapInValues, err := genesisConfig.InitialNodesBalances(shardC, node.addrConverter)
	if err != nil {
		return nil, err
	}

	for pubKey, value := range mapInValues {
		_ = debugInit.CreateAccount(node.acnts, []byte(pubKey), 0, value)
	}

	node.txProcessor, node.blockChainHook = debugInit.CreateTxProcessorWithOneSCExecutorWithVMs(node.acnts)

	return node, nil
}

const defaultRound uint64 = 444

// DeploySmartContract deploys a smart contract (with its code).
func (node *SimpleDebugNode) DeploySmartContract(command DeploySmartContractCommand) ([]byte, error) {
	if command.OnTestnet {
		return node.deploySmartContractOnTestnet(command)
	}

	return node.deploySmartContractOnDebugNode(command)
}

func (node *SimpleDebugNode) deploySmartContractOnTestnet(command DeploySmartContractCommand) ([]byte, error) {
	privateKey, _ := readPrivateKeyFromPemText(command.PrivateKey)
	publicKey, _ := privateKey.GeneratePublic().ToByteArray()

	nonce, err := getNonce(command.TestnetNodeEndpoint, publicKey)
	if err != nil {
		return nil, err
	}

	txData := command.Code + "@" + hex.EncodeToString(factory.ArwenVirtualMachine)
	for _, arg := range command.ArgsBuff {
		txData += "@" + hex.EncodeToString(arg)
	}

	tx := &transaction.Transaction{
		Nonce:    nonce,
		Value:    big.NewInt(0),
		RcvAddr:  debugInit.CreateEmptyAddress().Bytes(),
		SndAddr:  publicKey,
		Data:     txData,
		GasLimit: 10000,
		GasPrice: 0,
	}

	resultingAddress, err := node.blockChainHook.NewAddress(publicKey, nonce, factory.ArwenVirtualMachine)
	if err != nil {
		return nil, err
	}

	txBuff := signAndstringifyTransaction(tx, privateKey)
	err = sendTransaction(command.TestnetNodeEndpoint, txBuff)
	return resultingAddress, err
}

func (node *SimpleDebugNode) deploySmartContractOnDebugNode(command DeploySmartContractCommand) ([]byte, error) {
	accAddress, err := node.addrConverter.CreateAddressFromPublicKeyBytes([]byte(command.SndAddress))
	if err != nil {
		return nil, err
	}

	account, err := node.acnts.GetAccountWithJournal(accAddress)
	if err != nil {
		return nil, err
	}

	txData := command.Code + "@" + hex.EncodeToString(factory.ArwenVirtualMachine)
	for _, arg := range command.ArgsBuff {
		txData += "@" + hex.EncodeToString(arg)
	}

	resultingAddress, err := node.blockChainHook.NewAddress(command.SndAddress, account.GetNonce(), factory.ArwenVirtualMachine)
	if err != nil {
		return nil, err
	}

	tx := &transaction.Transaction{
		Nonce:     account.GetNonce(),
		Value:     big.NewInt(0),
		RcvAddr:   debugInit.CreateEmptyAddress().Bytes(),
		SndAddr:   []byte(command.SndAddress),
		GasPrice:  0,
		GasLimit:  10000,
		Data:      txData,
		Signature: nil,
		Challenge: nil,
	}

	err = node.txProcessor.ProcessTransaction(tx, defaultRound)
	if err != nil {
		return nil, err
	}

	_, err = node.acnts.Commit()
	if err != nil {
		return nil, err
	}

	return resultingAddress, nil
}

// RunSmartContract runs a smart contract (a function defined by the smart contract).
func (node *SimpleDebugNode) RunSmartContract(command RunSmartContractCommand) ([]byte, error) {
	if command.OnTestnet {
		return node.runSmartContractOnTestnet(command)
	}

	return node.runSmartContractOnDebugNode(command)
}

func (node *SimpleDebugNode) runSmartContractOnTestnet(command RunSmartContractCommand) ([]byte, error) {
	privateKey, _ := readPrivateKeyFromPemText(command.PrivateKey)
	publicKey, _ := privateKey.GeneratePublic().ToByteArray()

	nonce, err := getNonce(command.TestnetNodeEndpoint, publicKey)
	if err != nil {
		return nil, err
	}

	valueAsString := command.Value
	value, ok := big.NewInt(0).SetString(valueAsString, 10)
	if !ok {
		return nil, errors.New("value is not in base 10 format")
	}

	txData := command.FuncName
	for _, arg := range command.FuncArgsBuff {
		txData += "@" + hex.EncodeToString(arg)
	}

	tx := &transaction.Transaction{
		Nonce:    nonce,
		Value:    value,
		RcvAddr:  []byte(command.ScAddress),
		SndAddr:  publicKey,
		GasPrice: command.GasPrice,
		GasLimit: command.GasLimit,
		Data:     txData,
	}

	txBuff := signAndstringifyTransaction(tx, privateKey)
	err = sendTransaction(command.TestnetNodeEndpoint, txBuff)
	return nil, err
}

func (node *SimpleDebugNode) runSmartContractOnDebugNode(command RunSmartContractCommand) ([]byte, error) {
	accAddress, err := node.addrConverter.CreateAddressFromPublicKeyBytes([]byte(command.SndAddress))
	if err != nil {
		return nil, err
	}

	account, err := node.acnts.GetAccountWithJournal(accAddress)
	if err != nil {
		return nil, err
	}

	stAcc, ok := account.(*state.Account)
	if !ok {
		return nil, errors.New("wrong type of account")
	}

	valueAsString := command.Value
	value, ok := big.NewInt(0).SetString(valueAsString, 10)
	if !ok {
		return nil, errors.New("value is not in base 10 format")
	}

	if stAcc.Balance.Cmp(value) < 0 {
		err = stAcc.SetBalanceWithJournal(value)
		if err != nil {
			return nil, err
		}
	}

	txData := command.FuncName
	for _, arg := range command.FuncArgsBuff {
		txData += "@" + hex.EncodeToString(arg)
	}

	tx := &transaction.Transaction{
		Nonce:     account.GetNonce(),
		Value:     value,
		RcvAddr:   []byte(command.ScAddress),
		SndAddr:   []byte(command.SndAddress),
		GasPrice:  command.GasPrice,
		GasLimit:  command.GasLimit,
		Data:      txData,
		Signature: nil,
		Challenge: nil,
	}

	err = node.txProcessor.ProcessTransaction(tx, defaultRound)
	if err != nil {
		return nil, err
	}

	return node.acnts.Commit()
}

func (node *SimpleDebugNode) IsInterfaceNil() bool {
	if node == nil {
		return true
	}
	return false
}

type getNonceResponse struct {
	Address string `json:"address"`
	Nonce   uint64 `json:"nonce"`
}

func getNonce(nodeAPIUrl string, senderAddress []byte) (uint64, error) {
	senderAddressEncoded := hex.EncodeToString(senderAddress)
	url := fmt.Sprintf("%s/address/%s", nodeAPIUrl, senderAddressEncoded)
	log.Println("getNonce, execute GET:")
	log.Println(url)
	response, err := http.Get(url)
	if err != nil {
		return 0, err
	}

	defer response.Body.Close()
	structuredResponse := getNonceResponse{}
	err = json.NewDecoder(response.Body).Decode(&structuredResponse)
	return structuredResponse.Nonce, err
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

	response, err := http.Post(url, "application/json", bytes.NewBuffer(txBuff))
	if err != nil {
		return err
	}

	defer response.Body.Close()
	structuredResponse := sendTransactionResponse{}
	err = json.NewDecoder(response.Body).Decode(&structuredResponse)
	return err
}

func readPrivateKeyFromPemText(pemText string) (crypto.PrivateKey, error) {
	suite := kyber.NewBlakeSHA256Ed25519()
	keyGenerator := signing.NewKeyGenerator(suite)
	keyBlock, _ := pem.Decode([]byte(pemText))
	keyBytes := keyBlock.Bytes

	keyBytesDecoded, err := hex.DecodeString(string(keyBytes))
	if err != nil {
		return nil, err
	}

	privateKey, err := keyGenerator.PrivateKeyFromByteArray(keyBytesDecoded)
	return privateKey, err
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

func signAndstringifyTransaction(tx *transaction.Transaction, privateKey crypto.PrivateKey) []byte {
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
	jsonFriendlyTx.Data = tx.Data
	jsonFriendlyTx.Signature = hex.EncodeToString(tx.Signature)

	jsonFriendlyTxBuff, _ := marshal.JsonMarshalizer{}.Marshal(jsonFriendlyTx)

	return jsonFriendlyTxBuff
}
