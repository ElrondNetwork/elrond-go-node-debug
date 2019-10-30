package vmValues

import (
	"encoding/hex"
	"errors"
	"fmt"
	"math/big"
	"net/http"

	"github.com/ElrondNetwork/elrond-go-node-debug/node"

	apiErrors "github.com/ElrondNetwork/elrond-go/api/errors"
	"github.com/gin-gonic/gin"
)

// FacadeHandler interface defines methods that can be used from `elrondFacade` context variable
type FacadeHandler interface {
	GetVmValue(address string, funcName string, argsBuff ...[]byte) ([]byte, error)
	DeploySmartContract(command node.DeploySmartContractCommand) ([]byte, error)
	RunSmartContract(command node.RunSmartContractCommand) ([]byte, error)
	IsInterfaceNil() bool
}

// VmValueRequest represents the structure on which user input for generating a new transaction will validate against
type VmValueRequest struct {
	ScAddress string   `form:"scAddress" json:"scAddress"`
	FuncName  string   `form:"funcName" json:"funcName"`
	Args      []string `form:"args"  json:"args"`
}

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

// Routes defines address related routes
func Routes(router *gin.RouterGroup) {
	router.POST("/hex", GetVmValueAsHexBytes)
	router.POST("/string", GetVmValueAsString)
	router.POST("/int", GetVmValueAsBigInt)
	router.POST("/deploy", DeploySmartContract)
	router.POST("/run", RunSmartContract)
}

func vmValueFromAccount(c *gin.Context) ([]byte, int, error) {
	ef, ok := c.MustGet("elrondFacade").(FacadeHandler)
	if !ok {
		return nil, http.StatusInternalServerError, apiErrors.ErrInvalidAppContext
	}

	var gval = VmValueRequest{}
	err := c.ShouldBindJSON(&gval)
	if err != nil {
		return nil, http.StatusBadRequest, err
	}

	argsBuff := make([][]byte, 0)
	for _, arg := range gval.Args {
		buff, err := hex.DecodeString(arg)
		if err != nil {
			return nil,
				http.StatusBadRequest,
				errors.New(fmt.Sprintf("'%s' is not a valid hex string: %s", arg, err.Error()))
		}

		argsBuff = append(argsBuff, buff)
	}

	adrBytes, err := hex.DecodeString(gval.ScAddress)
	if err != nil {
		return nil,
			http.StatusBadRequest,
			errors.New(fmt.Sprintf("'%s' is not a valid hex string: %s", gval.ScAddress, err.Error()))
	}

	returnedData, err := ef.GetVmValue(string(adrBytes), gval.FuncName, argsBuff...)
	if err != nil {
		return nil, http.StatusBadRequest, err
	}

	return returnedData, http.StatusOK, nil
}

// GetVmValueAsHexBytes returns the data as byte slice
func GetVmValueAsHexBytes(c *gin.Context) {
	data, status, err := vmValueFromAccount(c)
	if err != nil {
		c.JSON(status, gin.H{"error": fmt.Sprintf("get value as hex bytes: %s", err)})
		return
	}

	c.JSON(http.StatusOK, gin.H{"data": hex.EncodeToString(data)})
}

// GetVmValueAsString returns the data as string
func GetVmValueAsString(c *gin.Context) {
	data, status, err := vmValueFromAccount(c)
	if err != nil {
		c.JSON(status, gin.H{"error": fmt.Sprintf("get value as string: %s", err)})
		return
	}

	c.JSON(http.StatusOK, gin.H{"data": string(data)})
}

// GetVmValueAsBigInt returns the data as big int
func GetVmValueAsBigInt(c *gin.Context) {
	data, status, err := vmValueFromAccount(c)
	if err != nil {
		c.JSON(status, gin.H{"error": fmt.Sprintf("get value as big int: %s", err)})
		return
	}

	value := big.NewInt(0).SetBytes(data)
	c.JSON(http.StatusOK, gin.H{"data": value.String()})
}

// DeploySmartContract deploys a smart contract.
// Returns the address of the smart contract.
func DeploySmartContract(ginContext *gin.Context) {
	scAddress, status, err := performDeploySmartContract(ginContext)

	if err != nil {
		ginContext.JSON(status, gin.H{"error": fmt.Sprintf("deploy smart contract: %s", err)})
		return
	}

	scAddressEncoded := hex.EncodeToString(scAddress)
	ginContext.JSON(http.StatusOK, gin.H{"data": scAddressEncoded})
}

// RunSmartContract runs a smart contract.
func RunSmartContract(ginContext *gin.Context) {
	data, status, err := performRunSmartContract(ginContext)
	if err != nil {
		ginContext.JSON(status, gin.H{"error": fmt.Sprintf("run smart contract: %s", err)})
		return
	}

	dataEncoded := hex.EncodeToString(data)
	ginContext.JSON(http.StatusOK, gin.H{"data": dataEncoded})
}

func performDeploySmartContract(ginContext *gin.Context) ([]byte, int, error) {
	ef, _ := ginContext.MustGet("elrondFacade").(FacadeHandler)

	command, err := convertRequestToDeployCommand(ginContext)
	if err != nil {
		return nil, http.StatusBadRequest, err
	}

	returnedData, err := ef.DeploySmartContract(*command)
	if err != nil {
		return nil, http.StatusBadRequest, err
	}

	return returnedData, http.StatusOK, nil
}

func performRunSmartContract(ginContext *gin.Context) ([]byte, int, error) {
	ef, _ := ginContext.MustGet("elrondFacade").(FacadeHandler)

	command, err := convertRequestToRunCommand(ginContext)
	if err != nil {
		return nil, http.StatusBadRequest, err
	}

	returnedData, err := ef.RunSmartContract(*command)
	if err != nil {
		return nil, http.StatusBadRequest, err
	}

	return returnedData, http.StatusOK, nil
}

func convertRequestToDeployCommand(ginContext *gin.Context) (*node.DeploySmartContractCommand, error) {
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

	command := &node.DeploySmartContractCommand{
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

func convertRequestToRunCommand(ginContext *gin.Context) (*node.RunSmartContractCommand, error) {
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

	command := &node.RunSmartContractCommand{
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
