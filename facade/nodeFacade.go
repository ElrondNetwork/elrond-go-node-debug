package facade

import (
	"fmt"
	"github.com/ElrondNetwork/elrond-go-node-debug/node"
	"github.com/ElrondNetwork/elrond-go/node/heartbeat"
	"strconv"
	"sync"

	"github.com/ElrondNetwork/elrond-go-node-debug/api/vmValues"
	"github.com/ElrondNetwork/elrond-go/api/middleware"
	"github.com/ElrondNetwork/elrond-go/config"
	"github.com/ElrondNetwork/elrond-go/core/logger"
	"github.com/ElrondNetwork/elrond-go/core/statistics"
	baseFacade "github.com/ElrondNetwork/elrond-go/facade"
	"github.com/ElrondNetwork/elrond-go/node/external"
	"github.com/ElrondNetwork/elrond-go/ntp"
	"github.com/gin-gonic/gin"
)

// DefaultRestPort is the default port the REST API will start on if not specified
const DefaultRestPort = "8080"

// DefaultRestPortOff is the default value that should be passed if it is desired
//  to start the node without a REST endpoint available
const DefaultRestPortOff = "off"

// DebugVMFacade represents a facade for grouping the functionality for node, transaction and address
type DebugVMFacade struct {
	apiResolver            baseFacade.ApiResolver
	debugNode              node.ProcessSmartContract
	syncer                 ntp.SyncTimer
	log                    *logger.Logger
	tpsBenchmark           *statistics.TpsBenchmark
	config                 *config.FacadeConfig
	restAPIServerDebugMode bool
}

func (ef *DebugVMFacade) GetCurrentPublicKey() string {
	return ""
}

func (ef *DebugVMFacade) GetHeartbeats() ([]heartbeat.PubKeyHeartbeat, error) {
	return nil, nil
}

// NewDebugVMFacade creates a new Facade with a NodeWrapper
func NewDebugVMFacade(apiResolver baseFacade.ApiResolver, debugNode node.ProcessSmartContract, restAPIServerDebugMode bool) *DebugVMFacade {
	return &DebugVMFacade{
		apiResolver:            apiResolver,
		debugNode:              debugNode,
		restAPIServerDebugMode: restAPIServerDebugMode,
	}
}

// SetLogger sets the current logger
func (ef *DebugVMFacade) SetLogger(log *logger.Logger) {
	ef.log = log
}

// SetSyncer sets the current syncer
func (ef *DebugVMFacade) SetSyncer(syncer ntp.SyncTimer) {
	ef.syncer = syncer
}

// SetTpsBenchmark sets the tps benchmark handler
func (ef *DebugVMFacade) SetTpsBenchmark(tpsBenchmark *statistics.TpsBenchmark) {
	ef.tpsBenchmark = tpsBenchmark
}

// TpsBenchmark returns the tps benchmark handler
func (ef *DebugVMFacade) TpsBenchmark() *statistics.TpsBenchmark {
	return ef.tpsBenchmark
}

// SetConfig sets the configuration options for the facade
func (ef *DebugVMFacade) SetConfig(facadeConfig *config.FacadeConfig) {
	ef.config = facadeConfig
}

// StartNode starts the underlying node
func (ef *DebugVMFacade) StartNode() error {
	return nil
}

// StopNode stops the underlying node
func (ef *DebugVMFacade) StopNode() error {
	return nil
}

// StartBackgroundServices starts all background services needed for the correct functionality of the node
func (ef *DebugVMFacade) StartBackgroundServices(wg *sync.WaitGroup) {
	wg.Add(1)
	go ef.startRest(wg)
}

// IsNodeRunning gets if the underlying node is running
func (ef *DebugVMFacade) IsNodeRunning() bool {
	return true
}

// RestAPIServerDebugMode return true is debug mode for Rest API is enabled
func (ef *DebugVMFacade) RestAPIServerDebugMode() bool {
	return ef.restAPIServerDebugMode
}

// RestApiPort returns the port on which the api should start on, based on the config file provided.
// The API will start on the DefaultRestPort value unless a correct value is passed or
//  the value is explicitly set to off, in which case it will not start at all
func (ef *DebugVMFacade) RestApiPort() string {
	if ef.config == nil {
		return DefaultRestPort
	}
	if ef.config.RestApiPort == "" {
		return DefaultRestPort
	}
	if ef.config.RestApiPort == DefaultRestPortOff {
		return DefaultRestPortOff
	}

	_, err := strconv.ParseInt(ef.config.RestApiPort, 10, 32)
	if err != nil {
		return DefaultRestPort
	}

	return ef.config.RestApiPort
}

// PrometheusMonitoring returns if prometheus is enabled for monitoring by the flag
func (ef *DebugVMFacade) PrometheusMonitoring() bool {
	return ef.config.Prometheus
}

// PrometheusJoinURL will return the join URL from server.toml
func (ef *DebugVMFacade) PrometheusJoinURL() string {
	return ef.config.PrometheusJoinURL
}

// PrometheusNetworkID will return the NetworkID from config.toml or the flag
func (ef *DebugVMFacade) PrometheusNetworkID() string {
	return ef.config.PrometheusJobName
}

func (ef *DebugVMFacade) startRest(wg *sync.WaitGroup) {
	defer wg.Done()

	port := ef.RestApiPort()

	if port == DefaultRestPortOff {
		ef.log.Info(fmt.Sprintf("Web server is off"))
	} else {
		ef.log.Info("Starting web server...")

		ws := gin.Default()
		vmValuesRoutes := ws.Group("/vm-values")
		vmValuesRoutes.Use(middleware.WithElrondFacade(ef))
		vmValues.Routes(vmValuesRoutes)

		ws.Run(fmt.Sprintf(":%s", port))
	}
}

// StatusMetrics will return the node's status metrics
func (ef *DebugVMFacade) StatusMetrics() external.StatusMetricsHandler {
	return ef.apiResolver.StatusMetrics()
}

// GetVmValue retrieves data from existing SC trie
func (ef *DebugVMFacade) GetVmValue(address string, funcName string, argsBuff ...[]byte) ([]byte, error) {
	return ef.apiResolver.GetVmValue(address, funcName, argsBuff...)
}

// RunSmartContract deploys a smart contract.
func (ef *DebugVMFacade) DeploySmartContract(command node.DeploySmartContractCommand) ([]byte, error) {
	return ef.debugNode.DeploySmartContract(command)
}

// RunSmartContract runs a smart contract function.
func (ef *DebugVMFacade) RunSmartContract(command node.RunSmartContractCommand) ([]byte, error) {
	return ef.debugNode.RunSmartContract(command)
}

// PprofEnabled returns if profiling mode should be active or not on the application
func (ef *DebugVMFacade) PprofEnabled() bool {
	return ef.config.PprofEnabled
}

// IsInterfaceNil returns true if there is no value under the interface
func (ef *DebugVMFacade) IsInterfaceNil() bool {
	if ef == nil {
		return true
	}
	return false
}
