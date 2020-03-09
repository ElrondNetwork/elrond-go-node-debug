package stubs

import (
	"math"
	"math/big"

	"github.com/ElrondNetwork/elrond-go/process"
)

var _ process.FeeHandler = (*MyFeeHandlerStub)(nil)

// MyFeeHandlerStub is a stub.
type MyFeeHandlerStub struct {
}

// DeveloperPercentage is a stub.
func (stub *MyFeeHandlerStub) DeveloperPercentage() float64 {
	return float64(0.3)
}

// MaxGasLimitPerBlock is a stub.
func (stub *MyFeeHandlerStub) MaxGasLimitPerBlock() uint64 {
	return math.MaxInt32
}

// ComputeGasLimit is a stub.
func (stub *MyFeeHandlerStub) ComputeGasLimit(tx process.TransactionWithFeeHandler) uint64 {
	return 0
}

// ComputeFee is a stub.
func (stub *MyFeeHandlerStub) ComputeFee(tx process.TransactionWithFeeHandler) *big.Int {
	return big.NewInt(0)
}

// MinGasPrice is a stub.
func (stub *MyFeeHandlerStub) MinGasPrice() uint64 {
	return 10000
}

// CheckValidityTxValues is a stub.
func (stub *MyFeeHandlerStub) CheckValidityTxValues(tx process.TransactionWithFeeHandler) error {
	return nil
}

// IsInterfaceNil is a stub.
func (stub *MyFeeHandlerStub) IsInterfaceNil() bool {
	return false
}
