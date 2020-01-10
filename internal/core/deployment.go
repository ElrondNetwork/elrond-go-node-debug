package core

import (
	"encoding/hex"
	"errors"
	"fmt"
	"math/big"

	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/ElrondNetwork/elrond-go/process/factory"
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
	"github.com/gin-gonic/gin"
)

// DeploySCRequest represents the structure on which user input for generating a new transaction will validate against
type DeploySCRequest struct {
	OnTestnet           bool   `form:"onTestnet" json:"onTestnet"`
	PrivateKey          string `form:"privateKey" json:"privateKey"`
	TestnetNodeEndpoint string `form:"testnetNodeEndpoint" json:"testnetNodeEndpoint"`
	SndAddress          string `form:"sndAddress" json:"sndAddress"`
	Value               string `form:"value" json:"value"`
	GasLimit            uint64 `form:"gasLimit" json:"gasLimit"`
	GasPrice            uint64 `form:"gasPrice" json:"gasPrice"`
	TxData              string `form:"txData" json:"txData"`
}

// DeploySmartContractCommand represents the command for deploying a smart contract
type DeploySmartContractCommand struct {
	OnTestnet           bool
	PrivateKey          string
	TestnetNodeEndpoint string
	SndAddressEncoded   string
	SndAddress          []byte
	Value               string
	GasPrice            uint64
	GasLimit            uint64
	TxData              string
}

// DeploySmartContractResponse represents the reponse for deploying a smart contract
type DeploySmartContractResponse struct {
	Address string
	Other   interface{}
}

func handlerDeploySmartContract(ginContext *gin.Context) {
	ef, _ := ginContext.MustGet("elrondFacade").(FacadeHandler)

	command, err := createDeployCommand(ginContext)
	if err != nil {
		returnBadRequest(ginContext, "deploySmartContract - createDeployCommand", err)
		return
	}

	scAddress, otherData, err := ef.DeploySmartContract(*command)
	if err != nil {
		returnBadRequest(ginContext, "deploySmartContract - actual deploy", err)
		return
	}

	response := DeploySmartContractResponse{
		Address: hex.EncodeToString(scAddress),
		Other:   otherData,
	}

	returnOkResponse(ginContext, response)
}

func createDeployCommand(ginContext *gin.Context) (*DeploySmartContractCommand, error) {
	request := DeploySCRequest{}

	err := ginContext.ShouldBindJSON(&request)
	if err != nil {
		return nil, err
	}

	adrBytes, err := hex.DecodeString(request.SndAddress)
	if err != nil {
		return nil, fmt.Errorf("'%s' is not a valid hex string: %s", request.SndAddress, err.Error())
	}

	if request.OnTestnet && request.PrivateKey == "" {
		return nil, fmt.Errorf("private key is missing")
	}

	command := &DeploySmartContractCommand{
		OnTestnet:           request.OnTestnet,
		PrivateKey:          request.PrivateKey,
		TestnetNodeEndpoint: request.TestnetNodeEndpoint,
		SndAddressEncoded:   request.SndAddress,
		SndAddress:          adrBytes,
		Value:               request.Value,
		GasLimit:            request.GasLimit,
		GasPrice:            request.GasPrice,
		TxData:              request.TxData,
	}

	return command, nil
}

// DeploySmartContract deploys a smart contract (with its code).
func (node *SimpleDebugNode) DeploySmartContract(command DeploySmartContractCommand) ([]byte, interface{}, error) {
	if command.OnTestnet {
		return node.deploySmartContractOnTestnet(command)
	}

	return node.deploySmartContractOnDebugNode(command)
}

func (node *SimpleDebugNode) deploySmartContractOnTestnet(command DeploySmartContractCommand) ([]byte, interface{}, error) {
	privateKey, err := readPrivateKeyFromPemText(command.PrivateKey)
	if err != nil {
		return nil, nil, err
	}

	publicKey, err := privateKey.GeneratePublic().ToByteArray()
	if err != nil {
		return nil, nil, err
	}

	nonce, err := getNonce(command.TestnetNodeEndpoint, publicKey)
	if err != nil {
		return nil, nil, err
	}

	valueAsString := command.Value
	value, ok := big.NewInt(0).SetString(valueAsString, 10)
	if !ok {
		return nil, nil, errors.New("value is not in base 10 format")
	}

	tx := &transaction.Transaction{
		Nonce:    nonce,
		Value:    value,
		RcvAddr:  CreateEmptyAddress().Bytes(),
		SndAddr:  publicKey,
		GasLimit: command.GasLimit,
		GasPrice: command.GasPrice,
		Data:     []byte(command.TxData),
	}

	resultingAddress, err := node.BlockChainHook.(vmcommon.BlockchainHook).NewAddress(publicKey, nonce, factory.ArwenVirtualMachine)
	if err != nil {
		return nil, nil, err
	}

	txBuff := signAndStringifyTransaction(tx, privateKey)
	sendTransactionResponse, err := sendTransaction(command.TestnetNodeEndpoint, txBuff)
	if err != nil {
		return nil, nil, err
	}

	return resultingAddress, sendTransactionResponse, err
}

func (node *SimpleDebugNode) deploySmartContractOnDebugNode(command DeploySmartContractCommand) ([]byte, interface{}, error) {
	accAddress, err := node.AddressConverter.CreateAddressFromPublicKeyBytes([]byte(command.SndAddress))
	if err != nil {
		return nil, nil, err
	}

	account, err := node.Accounts.GetAccountWithJournal(accAddress)
	if err != nil {
		return nil, nil, err
	}

	resultingAddress, err := node.BlockChainHook.(vmcommon.BlockchainHook).NewAddress(command.SndAddress, account.GetNonce(), factory.ArwenVirtualMachine)
	if err != nil {
		return nil, nil, err
	}

	valueAsString := command.Value
	value, ok := big.NewInt(0).SetString(valueAsString, 10)
	if !ok {
		return nil, nil, errors.New("value is not in base 10 format")
	}

	tx := &transaction.Transaction{
		Nonce:    account.GetNonce(),
		Value:    value,
		RcvAddr:  CreateEmptyAddress().Bytes(),
		SndAddr:  []byte(command.SndAddress),
		GasLimit: command.GasLimit,
		GasPrice: command.GasPrice,
		Data:     []byte(command.TxData),
	}

	err = node.TxProcessor.ProcessTransaction(tx)
	if err != nil {
		return nil, nil, err
	}

	_, err = node.Accounts.Commit()
	if err != nil {
		return nil, nil, err
	}

	return resultingAddress, nil, nil
}
