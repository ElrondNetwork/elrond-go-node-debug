package vmValues

import (
	"encoding/hex"
	"errors"
	"fmt"
	"math/big"
	"net/http"

	apiErrors "github.com/ElrondNetwork/elrond-go/api/errors"
	"github.com/gin-gonic/gin"
)

// FacadeHandler interface defines methods that can be used from `elrondFacade` context variable
type FacadeHandler interface {
	GetVmValue(address string, funcName string, argsBuff ...[]byte) ([]byte, error)
	DeploySmartContract(address string, code string, argsBuff ...[]byte) ([]byte, error)
	RunSmartContract(sndAddress string, scAddress string, value string, funcName string, argsBuff ...[]byte) ([]byte, error)
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
	SndAddress string   `form:"sndAddress" json:"sndAddress"`
	Code       string   `form:"code" json:"code"`
	Args       []string `form:"args"  json:"args"`
}

// RunSCRequest represents the structure on which user input for generating a new transaction will validate against
type RunSCRequest struct {
	SndAddress string   `form:"sndAddress" json:"sndAddress"`
	ScAddress  string   `form:"scAddress" json:"scAddress"`
	Value      string   `form:"value" json:"value"`
	FuncName   string   `form:"funcName" json:"funcName"`
	Args       []string `form:"args"  json:"args"`
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

// DeploySmartContract returns the data as big int
func DeploySmartContract(c *gin.Context) {
	scAddress, status, err := deploySCforAccount(c)

	if err != nil {
		c.JSON(status, gin.H{"error": fmt.Sprintf("deploy smart contract: %s", err)})
		return
	}

	scAddressEncoded := hex.EncodeToString(scAddress)
	c.JSON(http.StatusOK, gin.H{"data": scAddressEncoded})
}

// RunSmartContract returns the data as big int
func RunSmartContract(c *gin.Context) {
	data, status, err := runSCforAccount(c)
	if err != nil {
		c.JSON(status, gin.H{"error": fmt.Sprintf("run smart contract: %s", err)})
		return
	}

	dataEncoded := hex.EncodeToString(data)
	c.JSON(http.StatusOK, gin.H{"data": dataEncoded})
}

func deploySCforAccount(c *gin.Context) ([]byte, int, error) {
	ef, ok := c.MustGet("elrondFacade").(FacadeHandler)
	if !ok {
		return nil, http.StatusInternalServerError, apiErrors.ErrInvalidAppContext
	}

	var gval = DeploySCRequest{}
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

	adrBytes, err := hex.DecodeString(gval.SndAddress)
	if err != nil {
		return nil,
			http.StatusBadRequest,
			errors.New(fmt.Sprintf("'%s' is not a valid hex string: %s", gval.SndAddress, err.Error()))
	}

	returnedData, err := ef.DeploySmartContract(string(adrBytes), gval.Code, argsBuff...)
	if err != nil {
		return nil, http.StatusBadRequest, err
	}

	return returnedData, http.StatusOK, nil
}

func runSCforAccount(c *gin.Context) ([]byte, int, error) {
	ef, ok := c.MustGet("elrondFacade").(FacadeHandler)
	if !ok {
		return nil, http.StatusInternalServerError, apiErrors.ErrInvalidAppContext
	}

	var gval = RunSCRequest{}
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

	sndBytes, err := hex.DecodeString(gval.SndAddress)
	if err != nil {
		return nil,
			http.StatusBadRequest,
			errors.New(fmt.Sprintf("'%s' is not a valid hex string: %s", gval.SndAddress, err.Error()))
	}

	returnedData, err := ef.RunSmartContract(string(sndBytes), string(adrBytes), gval.Value, gval.FuncName, argsBuff...)
	if err != nil {
		return nil, http.StatusBadRequest, err
	}

	return returnedData, http.StatusOK, nil
}
