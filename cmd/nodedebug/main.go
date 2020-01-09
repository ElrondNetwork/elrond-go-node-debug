package main

import (
	"fmt"
	"log"
	"os"
	"os/signal"
	"path/filepath"
	"runtime"
	"runtime/debug"
	"sync"
	"syscall"

	debugCore "github.com/ElrondNetwork/elrond-go-node-debug/internal/core"
	"github.com/ElrondNetwork/elrond-go/cmd/node/factory"
	"github.com/ElrondNetwork/elrond-go/config"
	"github.com/ElrondNetwork/elrond-go/core"
	"github.com/ElrondNetwork/elrond-go/data/state"
	factoryState "github.com/ElrondNetwork/elrond-go/data/state/factory"
	"github.com/ElrondNetwork/elrond-go/storage/pathmanager"
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
		return startDebugNode(c)
	}

	err := app.Run(os.Args)
	if err != nil {
		log.Fatal(err.Error())
	}
}

func startDebugNode(ctx *cli.Context) error {
	stop := make(chan bool, 1)
	sigs := make(chan os.Signal, 1)
	signal.Notify(sigs, syscall.SIGINT, syscall.SIGTERM)

	fmt.Printf("Starting node\n")
	fmt.Printf("Process ID: %d\n", os.Getpid())

	generalConfig, err := loadMainConfig(ctx.GlobalString(configurationFile.Name))
	if err != nil {
		fmt.Println("error loading generalConfig " + err.Error())
		return err
	}

	var workingDir = ""
	if ctx.IsSet(workingDirectory.Name) {
		workingDir = ctx.GlobalString(workingDirectory.Name)
	} else {
		workingDir, err = os.Getwd()
		if err != nil {
			log.LogIfError(err)
			workingDir = ""
		}
	}
	log.Trace("working directory", "path", workingDir)

	var shardId = core.GetShardIdString(shardCoordinator.SelfId())

	defaultDBPath := "db"
	defaultEpochString := "Epoch"
	defaultStaticDbString := "Static"
	defaultShardString := "Shard"
	chainID := "undefined"

	pathTemplateForPruningStorer := filepath.Join(
		workingDir,
		defaultDBPath,
		chainID,
		fmt.Sprintf("%s_%s", defaultEpochString, core.PathEpochPlaceholder),
		fmt.Sprintf("%s_%s", defaultShardString, core.PathShardPlaceholder),
		core.PathIdentifierPlaceholder)

	pathTemplateForStaticStorer := filepath.Join(
		workingDir,
		defaultDBPath,
		chainID,
		defaultStaticDbString,
		fmt.Sprintf("%s_%s", defaultShardString, core.PathShardPlaceholder),
		core.PathIdentifierPlaceholder)

	pathManager, err := pathmanager.NewPathManager(pathTemplateForPruningStorer, pathTemplateForStaticStorer)
	if err != nil {
		return err
	}

	coreArgs := factory.NewCoreComponentsFactoryArgs(generalConfig, pathManager, shardId, []byte(chainID))
	coreComponents, err := factory.CoreComponentsFactory(coreArgs)
	if err != nil {
		fmt.Println("error creating core components " + err.Error())
		return err
	}

	accountFactory, err := factoryState.NewAccountFactoryCreator(factoryState.UserAccount)
	if err != nil {
		fmt.Println("could not create account factory: " + err.Error())
		return err
	}

	accountsAdapter, err := state.NewAccountsDB(coreComponents.Trie, coreComponents.Hasher, coreComponents.Marshalizer, accountFactory)
	if err != nil {
		fmt.Println("could not create accounts adapter: " + err.Error())
		return err
	}

	simpleDebugNode, err := debugCore.NewSimpleDebugNode(accountsAdapter)
	if err != nil {
		return err
	}

	simpleDebugNode.AddAccountsAccordingToGenesisFile(ctx.GlobalString(genesisFile.Name))

	ef := debugCore.NewNodeDebugFacade(simpleDebugNode, true)

	efConfig := &config.FacadeConfig{
		RestApiInterface: ctx.GlobalString(restApiPort.Name),
	}

	ef.SetConfig(efConfig)

	wg := sync.WaitGroup{}
	go ef.StartBackgroundServices(&wg)
	wg.Wait()

	log.Println("Bootstrapping node....")
	err = ef.StartNode()
	if err != nil {
		log.Println("starting node failed", err.Error())
		return err
	}

	go func() {
		<-sigs
		log.Println("terminating at user's signal...")
		stop <- true
	}()

	log.Println("Application is now running...")
	<-stop

	return nil
}

func loadMainConfig(filepath string) (*config.Config, error) {
	cfg := &config.Config{}
	err := core.LoadTomlFile(cfg, filepath)
	if err != nil {
		return nil, err
	}
	return cfg, nil
}
