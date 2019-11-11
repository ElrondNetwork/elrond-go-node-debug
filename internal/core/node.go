package core

import (
	"errors"

	"github.com/ElrondNetwork/elrond-go/data/state"
	"github.com/ElrondNetwork/elrond-go/data/state/addressConverters"
	"github.com/ElrondNetwork/elrond-go/process"
	"github.com/ElrondNetwork/elrond-go/sharding"
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
)

type SimpleDebugNode struct {
	acnts          state.AccountsAdapter
	txProcessor    process.TransactionProcessor
	blockChainHook vmcommon.BlockchainHook
	addrConverter  state.AddressConverter
}

func NewSimpleDebugNode(accnts state.AccountsAdapter, genesisFile string) (*SimpleDebugNode, error) {
	genesisConfig, err := sharding.NewGenesisConfig(genesisFile)
	if err != nil {
		return nil, err
	}

	if accnts == nil || accnts.IsInterfaceNil() {
		return nil, errors.New("nil accounts adapter")
	}

	node := &SimpleDebugNode{
		acnts:          accnts,
		txProcessor:    nil,
		blockChainHook: nil,
	}

	shardC, err := sharding.NewMultiShardCoordinator(1, 0)
	if err != nil {
		return nil, err
	}

	node.addrConverter, err = addressConverters.NewPlainAddressConverter(32, "0x")
	if err != nil {
		return nil, err
	}

	mapInValues, err := genesisConfig.InitialNodesBalances(shardC, node.addrConverter)
	if err != nil {
		return nil, err
	}

	for pubKey, value := range mapInValues {
		_ = CreateAccount(node.acnts, []byte(pubKey), 0, value)
	}

	node.txProcessor, node.blockChainHook = CreateTxProcessorWithOneSCExecutorWithVMs(node.acnts)

	return node, nil
}

const defaultRound uint64 = 444
