package stubs

import (
	"math/big"

	"github.com/ElrondNetwork/elrond-go/process"
)

var _ process.TransactionFeeHandler = (*MyTransactionFeeHandlerStub)(nil)

// MyTransactionFeeHandlerStub is a stub.
type MyTransactionFeeHandlerStub struct {
}

// GetAccumulatedFees is a stub.
func (stub *MyTransactionFeeHandlerStub) GetAccumulatedFees() *big.Int {
	return big.NewInt(42)
}

// CreateBlockStarted is a stub.
func (stub *MyTransactionFeeHandlerStub) CreateBlockStarted() {
}

// ProcessTransactionFee is a stub.
func (stub *MyTransactionFeeHandlerStub) ProcessTransactionFee(cost *big.Int) {
}

// IsInterfaceNil is a stub.
func (stub *MyTransactionFeeHandlerStub) IsInterfaceNil() bool {
	return false
}
