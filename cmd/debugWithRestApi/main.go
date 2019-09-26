package main

import (
	"fmt"
	"os"
	"os/signal"
	"path/filepath"
	"runtime"
	"runtime/debug"
	"sync"
	"syscall"

	debugVMFacade "github.com/ElrondNetwork/elrond-go-node-debug/facade"
	debugNode "github.com/ElrondNetwork/elrond-go-node-debug/node"
	"github.com/ElrondNetwork/elrond-go/cmd/node/factory"
	"github.com/ElrondNetwork/elrond-go/config"
	"github.com/ElrondNetwork/elrond-go/core"
	"github.com/ElrondNetwork/elrond-go/core/logger"
	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/state/addressConverters"
	factoryState "github.com/ElrondNetwork/elrond-go/data/state/factory"
	"github.com/ElrondNetwork/elrond-go/facade"
	"github.com/ElrondNetwork/elrond-go/node/external"
	"github.com/ElrondNetwork/elrond-go/process/factory/shard"
	"github.com/ElrondNetwork/elrond-go/process/smartContract"
	"github.com/ElrondNetwork/elrond-go/sharding"
	"github.com/ElrondNetwork/elrond-go/statusHandler"
	"github.com/urfave/cli"
)

var (
	nodeHelpTemplate = `NAME:
   {{.Name}} - {{.Usage}}
USAGE:
   {{.HelpName}} {{if .VisibleFlags}}[global options]{{end}}
   {{if len .Authors}}
AUTHOR:
   {{range .Authors}}{{ . }}{{end}}
   {{end}}{{if .Commands}}
GLOBAL OPTIONS:
   {{range .VisibleFlags}}{{.}}
   {{end}}
VERSION:
   {{.Version}}
   {{end}}
`
)

// restApiPort defines a flag for port on which the rest API will start on
var restApiPort = cli.StringFlag{
	Name:  "rest-api-port",
	Usage: "The port on which the rest API will start on",
	Value: "8080",
}

// configurationFile defines a flag for the path to the main toml configuration file
var configurationFile = cli.StringFlag{
	Name:  "config",
	Usage: "The main configuration file to load",
	Value: "./config/config.toml",
}

// genesisFile defines a flag for the path of the bootstrapping file.
var genesisFile = cli.StringFlag{
	Name:  "genesis-file",
	Usage: "The node will extract bootstrapping info from the genesis.json",
	Value: "./config/genesis.json",
}

func main() {
	log := logger.DefaultLogger()

	app := cli.NewApp()
	cli.AppHelpTemplate = nodeHelpTemplate
	app.Name = "Elrond Node CLI App"
	app.Version = fmt.Sprintf("%s/%s/%s-%s", "debug", runtime.Version(), runtime.GOOS, runtime.GOARCH)
	app.Usage = "This is the entry point for starting a new Elrond node - the app will start after the genesis timestamp"
	app.Flags = []cli.Flag{
		restApiPort,
		configurationFile,
		genesisFile,
	}
	app.Authors = []cli.Author{
		{
			Name:  "The Elrond Team",
			Email: "contact@elrond.com",
		},
	}

	//TODO: The next line should be removed when the write in batches is done
	// set the maximum allowed OS threads (not go routines) which can run in the same time (the default is 10000)
	debug.SetMaxThreads(100000)

	app.Action = func(c *cli.Context) error {
		return startDebugNode(c, log)
	}

	err := app.Run(os.Args)
	if err != nil {
		log.Error(err.Error())
		os.Exit(1)
	}

}

func startDebugNode(ctx *cli.Context, log *logger.Logger) error {
	stop := make(chan bool, 1)
	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)

	log.Info(fmt.Sprintf("Starting node"))
	log.Info(fmt.Sprintf("Process ID: %d\n", os.Getpid()))

	generalConfig, err := loadMainConfig(ctx.GlobalString(configurationFile.Name), log)
	if err != nil {
		fmt.Println("error loading generalConfig " + err.Error())
		return err
	}

	var workingDir = ""
	workingDir, err = os.Getwd()
	if err != nil {
		log.LogIfError(err)
		workingDir = ""
	}

	uniqueDBFolder := filepath.Join(
		workingDir,
		"defaultDBPath",
		fmt.Sprintf("%s_%d", "0", 0),
		fmt.Sprintf("%s_%s", "0", 0))

	coreArgs := factory.NewCoreComponentsFactoryArgs(generalConfig, uniqueDBFolder)
	coreComponents, err := factory.CoreComponentsFactory(coreArgs)
	if err != nil {
		fmt.Println("error creating core components " + err.Error())
		return err
	}

	addressConverter, err := addressConverters.NewPlainAddressConverter(generalConfig.Address.Length, generalConfig.Address.Prefix)
	if err != nil {
		fmt.Println("could not create address converter: " + err.Error())
		return err
	}

	shardCoordinator, err := sharding.NewMultiShardCoordinator(1, 0)
	if err != nil {
		return err
	}

	accountFactory, err := factoryState.NewAccountFactoryCreator(shardCoordinator)
	if err != nil {
		fmt.Println("could not create account factory: " + err.Error())
		return err
	}

	accountsAdapter, err := state.NewAccountsDB(coreComponents.Trie, coreComponents.Hasher, coreComponents.Marshalizer, accountFactory)
	if err != nil {
		fmt.Println("could not create accounts adapter: " + err.Error())
		return err
	}

	processorNode, err := debugNode.NewSimpleDebugNode(accountsAdapter, ctx.GlobalString(genesisFile.Name))
	if err != nil {
		return err
	}

	statusMetrics := statusHandler.NewStatusMetrics()
	apiResolver, err := createApiResolver(
		accountsAdapter,
		addressConverter,
		statusMetrics,
	)
	if err != nil {
		fmt.Println("error instantiating api resolver " + err.Error())
		return err
	}

	ef := debugVMFacade.NewDebugVMFacade(apiResolver, processorNode, true)

	efConfig := &config.FacadeConfig{
		RestApiPort: ctx.GlobalString(restApiPort.Name),
	}

	ef.SetLogger(log)
	ef.SetConfig(efConfig)

	wg := sync.WaitGroup{}
	go ef.StartBackgroundServices(&wg)
	wg.Wait()

	log.Info("Bootstrapping node....")
	err = ef.StartNode()
	if err != nil {
		log.Error("starting node failed", err.Error())
		return err
	}

	go func() {
		<-sigs
		log.Info("terminating at user's signal...")
		stop <- true
	}()

	log.Info("Application is now running...")
	<-stop

	return nil
}

func createApiResolver(accounts state.AccountsAdapter, converter state.AddressConverter, statusMetrics external.StatusMetricsHandler) (facade.ApiResolver, error) {
	vmFactory, err := shard.NewVMContainerFactory(accounts, converter)
	if err != nil {
		return nil, err
	}

	vmContainer, err := vmFactory.Create()
	if err != nil {
		return nil, err
	}

	scDataGetter, err := smartContract.NewSCDataGetter(vmContainer)
	if err != nil {
		return nil, err
	}

	return external.NewNodeApiResolver(scDataGetter, statusMetrics)
}

func loadMainConfig(filepath string, log *logger.Logger) (*config.Config, error) {
	cfg := &config.Config{}
	err := core.LoadTomlFile(cfg, filepath, log)
	if err != nil {
		return nil, err
	}
	return cfg, nil
}
