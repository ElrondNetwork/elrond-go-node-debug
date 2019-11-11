package core

import (
	"encoding/hex"
	"encoding/pem"
	"fmt"
	"net/http"

	"github.com/ElrondNetwork/elrond-go/crypto"
	"github.com/ElrondNetwork/elrond-go/crypto/signing"
	"github.com/ElrondNetwork/elrond-go/crypto/signing/kyber"
	"github.com/gin-gonic/gin"
)

func returnBadRequest(context *gin.Context, errScope string, err error) {
	message := fmt.Sprintf("%s: %s", errScope, err)
	context.JSON(http.StatusBadRequest, gin.H{"error": message})
}

func returnOkResponse(context *gin.Context, data interface{}) {
	context.JSON(http.StatusOK, gin.H{"data": data})
}

func readPrivateKeyFromPemText(pemText string) (crypto.PrivateKey, error) {
	suite := kyber.NewBlakeSHA256Ed25519()
	keyGenerator := signing.NewKeyGenerator(suite)
	keyBlock, _ := pem.Decode([]byte(pemText))
	keyBytes := keyBlock.Bytes

	keyBytesDecoded, err := hex.DecodeString(string(keyBytes))
	if err != nil {
		return nil, err
	}

	privateKey, err := keyGenerator.PrivateKeyFromByteArray(keyBytesDecoded)
	return privateKey, err
}
