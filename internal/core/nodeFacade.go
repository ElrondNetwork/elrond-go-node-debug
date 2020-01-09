package core

import (
	"fmt"
	"strconv"
	"sync"

	"github.com/ElrondNetwork/elrond-go/node/heartbeat"
	"github.com/ElrondNetwork/elrond-go/process"
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
	"github.com/prometheus/common/log"

	"github.com/ElrondNetwork/elrond-go/api/middleware"
	"github.com/ElrondNetwork/elrond-go/config"
	"github.com/ElrondNetwork/elrond-go/core/statistics"
	"github.com/ElrondNetwork/elrond-go/node/external"
	"github.com/ElrondNetwork/elrond-go/ntp"
	"github.com/gin-gonic/gin"
)

// DefaultRestPort is the default port the REST API will start on if not specified
const DefaultRestPort = "8080"

// DefaultRestPortOff is the default value that should be passed if it is desired
//  to start the node without a REST endpoint available
const DefaultRestPortOff = "off"

// NodeDebugFacade represents a facade for grouping the functionality for node, transaction and address
type NodeDebugFacade struct {
	debugNode              *SimpleDebugNode
	syncer                 ntp.SyncTimer
	tpsBenchmark           *statistics.TpsBenchmark
	config                 *config.FacadeConfig
	restAPIServerDebugMode bool
}

func (ef *NodeDebugFacade) GetCurrentPublicKey() string {
	return ""
}

func (ef *NodeDebugFacade) GetHeartbeats() ([]heartbeat.PubKeyHeartbeat, error) {
	return nil, nil
}

// NewNodeDebugFacade creates a new Facade with a NodeWrapper
func NewNodeDebugFacade(debugNode *SimpleDebugNode, restAPIServerDebugMode bool) *NodeDebugFacade {
	return &NodeDebugFacade{
		debugNode:              debugNode,
		restAPIServerDebugMode: restAPIServerDebugMode,
	}
}

// SetSyncer sets the current syncer
func (ef *NodeDebugFacade) SetSyncer(syncer ntp.SyncTimer) {
	ef.syncer = syncer
}

// SetTpsBenchmark sets the tps benchmark handler
func (ef *NodeDebugFacade) SetTpsBenchmark(tpsBenchmark *statistics.TpsBenchmark) {
	ef.tpsBenchmark = tpsBenchmark
}

// TpsBenchmark returns the tps benchmark handler
func (ef *NodeDebugFacade) TpsBenchmark() *statistics.TpsBenchmark {
	return ef.tpsBenchmark
}

// SetConfig sets the configuration options for the facade
func (ef *NodeDebugFacade) SetConfig(facadeConfig *config.FacadeConfig) {
	ef.config = facadeConfig
}

// StartNode starts the underlying node
func (ef *NodeDebugFacade) StartNode() error {
	return nil
}

// StopNode stops the underlying node
func (ef *NodeDebugFacade) StopNode() error {
	return nil
}

// StartBackgroundServices starts all background services needed for the correct functionality of the node
func (ef *NodeDebugFacade) StartBackgroundServices(wg *sync.WaitGroup) {
	wg.Add(1)
	go ef.startRest(wg)
}

// IsNodeRunning gets if the underlying node is running
func (ef *NodeDebugFacade) IsNodeRunning() bool {
	return true
}

// RestAPIServerDebugMode return true is debug mode for Rest API is enabled
func (ef *NodeDebugFacade) RestAPIServerDebugMode() bool {
	return ef.restAPIServerDebugMode
}

// RestApiPort returns the port on which the api should start on, based on the config file provided.
// The API will start on the DefaultRestPort value unless a correct value is passed or
//  the value is explicitly set to off, in which case it will not start at all
func (ef *NodeDebugFacade) RestApiPort() string {
	if ef.config == nil {
		return DefaultRestPort
	}
	if ef.config.RestApiInterface == "" {
		return DefaultRestPort
	}
	if ef.config.RestApiInterface == DefaultRestPortOff {
		return DefaultRestPortOff
	}

	_, err := strconv.ParseInt(ef.config.RestApiInterface, 10, 32)
	if err != nil {
		return DefaultRestPort
	}

	return ef.config.RestApiInterface
}

func (ef *NodeDebugFacade) startRest(wg *sync.WaitGroup) {
	defer wg.Done()

	port := ef.RestApiPort()

	if port == DefaultRestPortOff {
		log.Info(fmt.Sprintf("Web server is off"))
	} else {
		log.Info("Starting web server...")

		ws := gin.Default()
		vmValuesRoutes := ws.Group("/vm-values")
		vmValuesRoutes.Use(middleware.WithElrondFacade(ef))
		RegisterRoutes(vmValuesRoutes)

		ws.Run(fmt.Sprintf(":%s", port))
	}
}

// StatusMetrics will return the node's status metrics
func (ef *NodeDebugFacade) StatusMetrics() external.StatusMetricsHandler {
	return ef.debugNode.APIResolver.StatusMetrics()
}

// ExecuteSCQuery retrieves data from existing SC trie
func (ef *NodeDebugFacade) ExecuteSCQuery(query *process.SCQuery) (*vmcommon.VMOutput, error) {
	return ef.debugNode.APIResolver.ExecuteSCQuery(query)
}

// DeploySmartContract deploys a smart contract.
func (ef *NodeDebugFacade) DeploySmartContract(command DeploySmartContractCommand) ([]byte, error) {
	return ef.debugNode.DeploySmartContract(command)
}

// RunSmartContract runs a smart contract function.
func (ef *NodeDebugFacade) RunSmartContract(command RunSmartContractCommand) (interface{}, error) {
	return ef.debugNode.RunSmartContract(command)
}

// PprofEnabled returns if profiling mode should be active or not on the application
func (ef *NodeDebugFacade) PprofEnabled() bool {
	return ef.config.PprofEnabled
}

// IsInterfaceNil returns true if there is no value under the interface
func (ef *NodeDebugFacade) IsInterfaceNil() bool {
	if ef == nil {
		return true
	}
	return false
}
