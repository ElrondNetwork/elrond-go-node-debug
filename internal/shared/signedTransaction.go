package shared

import (
	"encoding/base64"
	"encoding/hex"

	"github.com/ElrondNetwork/elrond-go/crypto"
	"github.com/ElrondNetwork/elrond-go/crypto/signing/kyber/singlesig"
	"github.com/ElrondNetwork/elrond-go/data/transaction"
	"github.com/ElrondNetwork/elrond-go/marshal"
)

// SignedTransaction is a signed transaction
type SignedTransaction struct {
	Nonce     uint64 `json:"nonce"`
	Value     string `json:"value"`
	Receiver  string `json:"receiver"`
	Sender    string `json:"sender"`
	GasPrice  uint64 `json:"gasPrice"`
	GasLimit  uint64 `json:"gasLimit"`
	Data      string `json:"data"`
	Signature string `json:"signature"`
	Bytes     []byte
}

// NewSignedTransaction creates as signed transaction
func NewSignedTransaction(tx *transaction.Transaction, privateKey crypto.PrivateKey) (*SignedTransaction, error) {
	signer := &singlesig.SchnorrSigner{}
	txBuff, err := marshal.JsonMarshalizer{}.Marshal(tx)
	if err != nil {
		return nil, err
	}

	tx.Signature, err = signer.Sign(privateKey, txBuff)
	if err != nil {
		return nil, err
	}

	signedTransaction := &SignedTransaction{
		Nonce:     tx.Nonce,
		Value:     tx.Value.String(),
		Receiver:  hex.EncodeToString(tx.RcvAddr),
		Sender:    hex.EncodeToString(tx.SndAddr),
		GasPrice:  tx.GasPrice,
		GasLimit:  tx.GasLimit,
		Data:      base64.StdEncoding.EncodeToString(tx.Data),
		Signature: hex.EncodeToString(tx.Signature),
	}

	signedTransaction.Bytes, err = marshal.JsonMarshalizer{}.Marshal(signedTransaction)
	if err != nil {
		return nil, err
	}

	return signedTransaction, nil
}
