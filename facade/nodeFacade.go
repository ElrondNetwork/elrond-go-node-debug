package facade

import (
	"fmt"
	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/ElrondNetwork/elrond-go/node/heartbeat"
	"github.com/ElrondNetwork/elrond-go/process"
	"strconv"
	"sync"

	"github.com/ElrondNetwork/elrond-go/api"
	"github.com/ElrondNetwork/elrond-go/config"
	"github.com/ElrondNetwork/elrond-go/core/logger"
	"github.com/ElrondNetwork/elrond-go/core/statistics"
	baseFacade "github.com/ElrondNetwork/elrond-go/facade"
	"github.com/ElrondNetwork/elrond-go/node/external"
	"github.com/ElrondNetwork/elrond-go/ntp"
)

// DefaultRestPort is the default port the REST API will start on if not specified
const DefaultRestPort = "8080"

// DefaultRestPortOff is the default value that should be passed if it is desired
//  to start the node without a REST endpoint available
const DefaultRestPortOff = "off"

// ElrondNodeFacade represents a facade for grouping the functionality for node, transaction and address
type DebugVMFacade struct {
	apiResolver            baseFacade.ApiResolver
	txProcessor            process.TransactionProcessor
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

// NewElrondNodeFacade creates a new Facade with a NodeWrapper
func NewDebugVMFacade(
	apiResolver baseFacade.ApiResolver,
	txProcessor process.TransactionProcessor,
	restAPIServerDebugMode bool,
) *DebugVMFacade {
	if apiResolver == nil || apiResolver.IsInterfaceNil() {
		return nil
	}
	if txProcessor == nil || txProcessor.IsInterfaceNil() {
		return nil
	}

	return &DebugVMFacade{
		apiResolver:            apiResolver,
		txProcessor:            txProcessor,
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

	switch ef.RestApiPort() {
	case DefaultRestPortOff:
		ef.log.Info(fmt.Sprintf("Web server is off"))
		break
	default:
		ef.log.Info("Starting web server...")
		err := api.Start(ef)
		if err != nil {
			ef.log.Error("Could not start webserver", err.Error())
		}
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

const defaultRound uint64 = 444

func (ef *DebugVMFacade) DeploySmartContract(address string, code string, argsBuff ...[]byte) ([]byte, error) {
	tx := &transaction.Transaction{
		Nonce:     0,
		Value:     nil,
		RcvAddr:   nil,
		SndAddr:   nil,
		GasPrice:  0,
		GasLimit:  0,
		Data:      "",
		Signature: nil,
		Challenge: nil,
	}

	err := ef.txProcessor.ProcessTransaction(tx, defaultRound)

	return nil, err
}

func (ef *DebugVMFacade) RunSmartContract(
	sndAddress string,
	scAddress string,
	funcName string,
	argsBuff ...[]byte,
) ([]byte, error) {
	tx := &transaction.Transaction{
		Nonce:     0,
		Value:     nil,
		RcvAddr:   nil,
		SndAddr:   nil,
		GasPrice:  0,
		GasLimit:  0,
		Data:      "",
		Signature: nil,
		Challenge: nil,
	}

	err := ef.txProcessor.ProcessTransaction(tx, defaultRound)

	return nil, err
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
