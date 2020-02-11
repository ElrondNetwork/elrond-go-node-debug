package integrationtests

import (
	"encoding/hex"
	"testing"
	"time"

	"github.com/ElrondNetwork/elrond-go-node-debug/internal/core"
	"github.com/ElrondNetwork/elrond-go/process/factory"
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
	"github.com/stretchr/testify/require"
)

func Test_C_ERC20_OnTestnet(t *testing.T) {
	context := setupTestContext(t)
	smartContractCode := getSmartContractCode("./testdata/erc20-c/wrc20_arwen.wasm")

	scAddress, _, err := context.Node.DeploySmartContract(core.DeploySmartContractCommand{
		OnTestnet:           true,
		TestnetNodeEndpoint: proxyURL,
		PrivateKey:          getPemString(),
		SndAddress:          getOwnerAddressAsBytes(),
		Value:               "0",
		GasPrice:            100000000000000,
		GasLimit:            500000000,
		TxData:              smartContractCode + "@" + hex.EncodeToString(factory.ArwenVirtualMachine) + "@" + formatHexNumber(5000),
	})
	require.Nil(t, err)

	time.Sleep(30 * time.Second)

	_, err = context.Node.RunSmartContract(core.RunSmartContractCommand{
		OnTestnet:           true,
		TestnetNodeEndpoint: proxyURL,
		PrivateKey:          getPemString(),
		ScAddress:           scAddress,
		SndAddress:          getOwnerAddressAsBytes(),
		Value:               "0",
		GasPrice:            100000000000000,
		GasLimit:            500000000,
		TxData:              "transferToken@" + hex.EncodeToString(context.AliceAddress) + "@" + formatHexNumber(1000),
	})
	require.Nil(t, err)

	time.Sleep(30 * time.Second)

	vmOutput, err := core.DoExecuteQueryOnTestnet(core.VMValueRequest{
		OnTestnet:           true,
		TestnetNodeEndpoint: proxyURL,
		ScAddress:           hex.EncodeToString(scAddress),
		FuncName:            "balanceOf",
		Args:                []string{getOwnerAddress()}},
	)
	require.Nil(t, err)
	require.NotNil(t, vmOutput)

	returnData, err := vmOutput.GetFirstReturnData(vmcommon.AsBigIntString)
	require.Nil(t, err)
	require.Equal(t, "4000", returnData)
}
