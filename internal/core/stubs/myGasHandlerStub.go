package stubs

import (
	"github.com/ElrondNetwork/elrond-go/data"
	"github.com/ElrondNetwork/elrond-go/data/block"
)

type MyGasHandlerStub struct {
}

func (stub *MyGasHandlerStub) Init() {
}

func (stub *MyGasHandlerStub) SetGasConsumed(gasConsumed uint64, hash []byte) {
}

func (stub *MyGasHandlerStub) SetGasRefunded(gasRefunded uint64, hash []byte) {
}

func (stub *MyGasHandlerStub) GasConsumed(hash []byte) uint64 {
	return 42
}

func (stub *MyGasHandlerStub) GasRefunded(hash []byte) uint64 {
	return 42
}

func (stub *MyGasHandlerStub) TotalGasConsumed() uint64 {
	return 42
}

func (stub *MyGasHandlerStub) TotalGasRefunded() uint64 {
	return 42
}

func (stub *MyGasHandlerStub) RemoveGasConsumed(hashes [][]byte) {
}

func (stub *MyGasHandlerStub) RemoveGasRefunded(hashes [][]byte) {
}

func (stub *MyGasHandlerStub) ComputeGasConsumedByMiniBlock(miniBlock *block.MiniBlock, mapHashTx map[string]data.TransactionHandler) (uint64, uint64, error) {
	return 1, 1, nil
}

func (stub *MyGasHandlerStub) ComputeGasConsumedByTx(txSenderShardId uint32, txReceiverShardId uint32, txHandler data.TransactionHandler) (uint64, uint64, error) {
	return 1, 1, nil
}

func (stub *MyGasHandlerStub) IsInterfaceNil() bool {
	return false
}
