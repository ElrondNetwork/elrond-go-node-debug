package core

import (
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"

	"github.com/ElrondNetwork/elrond-go/process/smartContract"
	"github.com/gin-gonic/gin"
)

// FacadeHandler interface defines methods that can be used from `elrondFacade` context variable
type FacadeHandler interface {
	ExecuteSCQuery(query *smartContract.SCQuery) (*vmcommon.VMOutput, error)
	DeploySmartContract(command DeploySmartContractCommand) ([]byte, error)
	RunSmartContract(command RunSmartContractCommand) ([]byte, error)
}

// RegisterRoutes defines address related routes
func RegisterRoutes(router *gin.RouterGroup) {
	router.POST("/hex", handlerGetHex)
	router.POST("/string", handlerGetString)
	router.POST("/int", handlerGetInt)
	router.POST("/query", handlerExecuteQuery)
	router.POST("/deploy", handlerDeploySmartContract)
	router.POST("/run", handlerRunSmartContract)
}
