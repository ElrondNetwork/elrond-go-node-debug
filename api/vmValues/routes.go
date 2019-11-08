package vmValues

import (
	"encoding/hex"
	"fmt"
	"math/big"
	"net/http"

	"github.com/ElrondNetwork/elrond-go-node-debug/node"
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"

	"github.com/ElrondNetwork/elrond-go/process/smartContract"
	"github.com/gin-gonic/gin"
)

// FacadeHandler interface defines methods that can be used from `elrondFacade` context variable
type FacadeHandler interface {
	ExecuteSCQuery(query *smartContract.SCQuery) (*vmcommon.VMOutput, error)
	DeploySmartContract(command node.DeploySmartContractCommand) ([]byte, error)
	RunSmartContract(command node.RunSmartContractCommand) ([]byte, error)
	IsInterfaceNil() bool
}

// VMValueRequest represents the structure on which user input for generating a new transaction will validate against
type VMValueRequest struct {
	OnTestnet           bool     `form:"onTestnet" json:"onTestnet"`
	TestnetNodeEndpoint string   `form:"testnetNodeEndpoint" json:"testnetNodeEndpoint"`
	ScAddress           string   `form:"scAddress" json:"scAddress"`
	FuncName            string   `form:"funcName" json:"funcName"`
	Args                []string `form:"args"  json:"args"`
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
	router.POST("/hex", getHex)
	router.POST("/string", getString)
	router.POST("/int", getInt)
	router.POST("/query", executeQuery)
	router.POST("/deploy", deploySmartContract)
	router.POST("/run", runSmartContract)
}

func getHex(context *gin.Context) {
	doGetVMValue(context, vmcommon.AsHex)
}

func getString(context *gin.Context) {
	doGetVMValue(context, vmcommon.AsString)
}

func getInt(context *gin.Context) {
	doGetVMValue(context, vmcommon.AsBigIntString)
}

func doGetVMValue(context *gin.Context, asType vmcommon.ReturnDataKind) {
	vmOutput, err := doExecuteQuery(context)

	if err != nil {
		returnBadRequest(context, "doGetVMValue", err)
		return
	}

	returnData, err := vmOutput.GetFirstReturnData(asType)
	if err != nil {
		returnBadRequest(context, "doGetVMValue", err)
		return
	}

	returnOkResponse(context, returnData)
}

func executeQuery(context *gin.Context) {
	vmOutput, err := doExecuteQuery(context)
	if err != nil {
		returnBadRequest(context, "executeQuery", err)
		return
	}

	returnOkResponse(context, vmOutput)
}

func doExecuteQuery(context *gin.Context) (*vmcommon.VMOutput, error) {
	facade, _ := context.MustGet("elrondFacade").(FacadeHandler)

	request := VMValueRequest{}
	err := context.ShouldBindJSON(&request)
	if err != nil {
		return nil, err
	}

	command, err := createSCQuery(&request)
	if err != nil {
		return nil, err
	}

	vmOutput, err := facade.ExecuteSCQuery(command)
	if err != nil {
		return nil, err
	}

	return vmOutput, nil
}

func createSCQuery(request *VMValueRequest) (*smartContract.SCQuery, error) {
	decodedAddress, err := hex.DecodeString(request.ScAddress)
	if err != nil {
		return nil, fmt.Errorf("'%s' is not a valid hex string: %s", request.ScAddress, err.Error())
	}

	argumentsAsInt := make([]*big.Int, 0)
	for _, arg := range request.Args {
		argBytes, err := hex.DecodeString(arg)
		if err != nil {
			return nil, fmt.Errorf("'%s' is not a valid hex string: %s", arg, err.Error())
		}

		argumentsAsInt = append(argumentsAsInt, big.NewInt(0).SetBytes(argBytes))
	}

	return &smartContract.SCQuery{
		ScAddress: decodedAddress,
		FuncName:  request.FuncName,
		Arguments: argumentsAsInt,
	}, nil
}

func deploySmartContract(ginContext *gin.Context) {
	ef, _ := ginContext.MustGet("elrondFacade").(FacadeHandler)

	command, err := createDeployCommand(ginContext)
	if err != nil {
		returnBadRequest(ginContext, "deploySmartContract - createDeployCommand", err)
		return
	}

	scAddress, err := ef.DeploySmartContract(*command)
	if err != nil {
		returnBadRequest(ginContext, "deploySmartContract - actual deploy", err)
		return
	}

	scAddressEncoded := hex.EncodeToString(scAddress)
	returnOkResponse(ginContext, scAddressEncoded)
}

func runSmartContract(ginContext *gin.Context) {
	ef, _ := ginContext.MustGet("elrondFacade").(FacadeHandler)

	command, err := createRunCommand(ginContext)
	if err != nil {
		returnBadRequest(ginContext, "runSmartContract - createRunCommand", err)
		return
	}

	returnedData, err := ef.RunSmartContract(*command)
	if err != nil {
		returnBadRequest(ginContext, "runSmartContract - actual run", err)
		return
	}

	dataEncoded := hex.EncodeToString(returnedData)
	returnOkResponse(ginContext, dataEncoded)
}

func createDeployCommand(ginContext *gin.Context) (*node.DeploySmartContractCommand, error) {
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

func createRunCommand(ginContext *gin.Context) (*node.RunSmartContractCommand, error) {
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

func returnBadRequest(context *gin.Context, errScope string, err error) {
	message := fmt.Sprintf("%s: %s", errScope, err)
	context.JSON(http.StatusBadRequest, gin.H{"error": message})
}

func returnOkResponse(context *gin.Context, data interface{}) {
	context.JSON(http.StatusOK, gin.H{"data": data})
}
