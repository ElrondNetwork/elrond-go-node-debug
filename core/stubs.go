package core

import (
	"math/big"

	"github.com/ElrondNetwork/elrond-go/process"
)

// MyTransactionFeeHandlerStub is a stub.
type MyTransactionFeeHandlerStub struct {
}

// ProcessTransactionFee is a stub.
func (stub *MyTransactionFeeHandlerStub) ProcessTransactionFee(cost *big.Int) {
}

// IsInterfaceNil is a stub.
func (stub *MyTransactionFeeHandlerStub) IsInterfaceNil() bool {
	return false
}

// MyFeeHandlerStub is a stub.
type MyFeeHandlerStub struct {
}

// ComputeGasLimit is a stub.
func (stub *MyFeeHandlerStub) ComputeGasLimit(tx process.TransactionWithFeeHandler) uint64 {
	return 0
}

// ComputeFee is a stub.
func (stub *MyFeeHandlerStub) ComputeFee(tx process.TransactionWithFeeHandler) *big.Int {
	return big.NewInt(0)
}

// CheckValidityTxValues is a stub.
func (stub *MyFeeHandlerStub) CheckValidityTxValues(tx process.TransactionWithFeeHandler) error {
	return nil
}

// IsInterfaceNil is a stub.
func (stub *MyFeeHandlerStub) IsInterfaceNil() bool {
	return false
}
