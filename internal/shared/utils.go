package shared

import (
	"encoding/hex"
	"encoding/pem"
	"fmt"

	"github.com/ElrondNetwork/elrond-go/crypto"
	"github.com/ElrondNetwork/elrond-go/crypto/signing"
	"github.com/ElrondNetwork/elrond-go/crypto/signing/kyber"
	"github.com/ElrondNetwork/elrond-go/data/state"
)

// ReadPrivateKeyFromPemText reads a private key from a string
func ReadPrivateKeyFromPemText(pemText string) (crypto.PrivateKey, error) {
	suite := kyber.NewBlakeSHA256Ed25519()
	keyGenerator := signing.NewKeyGenerator(suite)
	keyBlock, _ := pem.Decode([]byte(pemText))
	if keyBlock == nil {
		return nil, fmt.Errorf("bad pem text")
	}

	keyBytes := keyBlock.Bytes
	keyBytesDecoded, err := hex.DecodeString(string(keyBytes))
	if err != nil {
		return nil, err
	}

	privateKey, err := keyGenerator.PrivateKeyFromByteArray(keyBytesDecoded)
	return privateKey, err
}

// CreateEmptyAddress creates an empty address
func CreateEmptyAddress() state.AddressContainer {
	return state.NewAddress(make([]byte, 32))
}
