package core

import (
	"encoding/hex"
	"fmt"
	"testing"

	"github.com/ElrondNetwork/elrond-go/process/factory"
	"github.com/stretchr/testify/require"
)

func Test_C_ERC20_OnTestnet(t *testing.T) {
	context := setupTestContext(t)
	smartContractCode := getSmartContractCode("./testdata/wrc20_arwen_c.wasm")
	ownerAddressBytes, _ := hex.DecodeString(ownerAddress)

	scAddress, _, err := context.Node.DeploySmartContract(DeploySmartContractCommand{
		OnTestnet:           true,
		TestnetNodeEndpoint: proxyURL,
		PrivateKey:          getPemString(),
		SndAddress:          ownerAddressBytes,
		Value:               "0",
		GasPrice:            100000000000000,
		GasLimit:            500000000,
		TxData:              smartContractCode + "@" + hex.EncodeToString(factory.ArwenVirtualMachine) + "@" + formatHexNumber(5000),
	})

	require.Nil(t, err)
	fmt.Println(scAddress)
	require.True(t, false)
}
