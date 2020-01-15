package core

import (
	"encoding/hex"
	"errors"
	"fmt"
	"math/big"

	"github.com/ElrondNetwork/arwen-wasm-vm/arwen/debugging"
	"github.com/ElrondNetwork/elrond-go-node-debug/internal/shared"
	"github.com/ElrondNetwork/elrond-go-node-debug/internal/testnet"
	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/transaction"
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
	"github.com/gin-gonic/gin"
)

// RunSCRequest represents the structure on which user input for generating a new transaction will validate against
type RunSCRequest struct {
	OnTestnet           bool   `form:"onTestnet" json:"onTestnet"`
	PrivateKey          string `form:"privateKey" json:"privateKey"`
	TestnetNodeEndpoint string `form:"testnetNodeEndpoint" json:"testnetNodeEndpoint"`
	SndAddress          string `form:"sndAddress" json:"sndAddress"`
	ScAddress           string `form:"scAddress" json:"scAddress"`
	Value               string `form:"value" json:"value"`
	GasLimit            uint64 `form:"gasLimit" json:"gasLimit"`
	GasPrice            uint64 `form:"gasPrice" json:"gasPrice"`
	TxData              string `form:"txData" json:"txData"`
}

// RunSmartContractCommand represents the command for running a smart contract.
type RunSmartContractCommand struct {
	OnTestnet           bool
	PrivateKey          string
	TestnetNodeEndpoint string
	SndAddressEncoded   string
	SndAddress          []byte
	ScAddress           []byte
	Value               string
	GasPrice            uint64
	GasLimit            uint64
	TxData              string
}

func handlerRunSmartContract(ginContext *gin.Context) {
	ef, _ := ginContext.MustGet("elrondFacade").(FacadeHandler)

	command, err := createRunCommand(ginContext)
	if err != nil {
		shared.ReturnBadRequest(ginContext, "runSmartContract - createRunCommand", err)
		return
	}

	result, err := ef.RunSmartContract(*command)
	if err != nil {
		shared.ReturnBadRequest(ginContext, "runSmartContract - actual run", err)
		return
	}

	shared.ReturnOkResponse(ginContext, result)
}

func createRunCommand(ginContext *gin.Context) (*RunSmartContractCommand, error) {
	request := RunSCRequest{}

	err := ginContext.ShouldBindJSON(&request)
	if err != nil {
		return nil, err
	}

	adrBytes, err := hex.DecodeString(request.ScAddress)
	if err != nil {
		return nil, fmt.Errorf("'%s' is not a valid hex string: %s", request.ScAddress, err.Error())
	}

	sndBytes, err := hex.DecodeString(request.SndAddress)
	if err != nil {
		return nil, fmt.Errorf("'%s' is not a valid hex string: %s", request.SndAddress, err.Error())
	}

	if request.OnTestnet && request.PrivateKey == "" {
		return nil, fmt.Errorf("private key is missing")
	}

	command := &RunSmartContractCommand{
		OnTestnet:           request.OnTestnet,
		PrivateKey:          request.PrivateKey,
		TestnetNodeEndpoint: request.TestnetNodeEndpoint,
		SndAddressEncoded:   request.SndAddress,
		SndAddress:          sndBytes,
		ScAddress:           adrBytes,
		Value:               request.Value,
		GasLimit:            request.GasLimit,
		GasPrice:            request.GasPrice,
		TxData:              request.TxData,
	}

	return command, nil
}

// RunSmartContract runs a smart contract (a function defined by the smart contract).
func (node *SimpleDebugNode) RunSmartContract(command RunSmartContractCommand) (interface{}, error) {
	if command.OnTestnet {
		return node.runSmartContractOnTestnet(command)
	}

	return node.runSmartContractOnDebugNode(command)
}

func (node *SimpleDebugNode) runSmartContractOnTestnet(command RunSmartContractCommand) (*testnet.SendTransactionResponse, error) {
	testnetProxy := testnet.NewProxy(command.TestnetNodeEndpoint)

	privateKey, err := shared.ReadPrivateKeyFromPemText(command.PrivateKey)
	if err != nil {
		return nil, err
	}

	publicKey, err := privateKey.GeneratePublic().ToByteArray()
	if err != nil {
		return nil, err
	}

	nonce, err := testnetProxy.GetNonce(publicKey)
	if err != nil {
		return nil, err
	}

	valueAsString := command.Value
	value, ok := big.NewInt(0).SetString(valueAsString, 10)
	if !ok {
		return nil, errors.New("value is not in base 10 format")
	}

	tx := &transaction.Transaction{
		Nonce:    nonce,
		Value:    value,
		RcvAddr:  command.ScAddress,
		SndAddr:  publicKey,
		GasPrice: command.GasPrice,
		GasLimit: command.GasLimit,
		Data:     []byte(command.TxData),
	}

	signedTransaction, err := shared.NewSignedTransaction(tx, privateKey)
	if err != nil {
		return nil, err
	}

	response, err := testnetProxy.SendTransaction(signedTransaction.Bytes)
	return response, err
}

func (node *SimpleDebugNode) runSmartContractOnDebugNode(command RunSmartContractCommand) (*vmcommon.VMOutput, error) {
	accAddress, err := node.AddressConverter.CreateAddressFromPublicKeyBytes([]byte(command.SndAddress))
	if err != nil {
		return nil, err
	}

	account, err := node.Accounts.GetAccountWithJournal(accAddress)
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

	tx := &transaction.Transaction{
		Nonce:    account.GetNonce(),
		Value:    value,
		RcvAddr:  command.ScAddress,
		SndAddr:  command.SndAddress,
		GasPrice: command.GasPrice,
		GasLimit: command.GasLimit,
		Data:     []byte(command.TxData),
	}

	err = node.TxProcessor.ProcessTransaction(tx)
	if err != nil {
		return nil, err
	}

	vmOutput := debugging.GlobalTrace.LatestVMOutput
	return vmOutput, nil
}
