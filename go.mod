module github.com/ElrondNetwork/elrond-go-node-debug

go 1.12

require (
	github.com/ElrondNetwork/elrond-go v1.0.18-0.20190925090404-cc062628fc67
	github.com/ElrondNetwork/elrond-vm-common v0.0.9
	github.com/gin-gonic/gin v1.3.0
	github.com/stretchr/testify v1.3.0
	github.com/urfave/cli v1.20.0
)

replace github.com/ElrondNetwork/elrond-vm-common v0.0.9 => github.com/ElrondNetwork/elrond-vm-common v0.0.8

replace github.com/ElrondNetwork/arwen-wasm-vm => ../arwen-wasm-vm

replace github.com/ElrondNetwork/managed-big-int => ../managed-big-int
