module github.com/ElrondNetwork/elrond-go-node-debug

go 1.12

require (
	github.com/ElrondNetwork/arwen-wasm-vm v0.3.1
	github.com/ElrondNetwork/elrond-go v0.0.0-20191125170548-29f8f6eb0293
	github.com/ElrondNetwork/elrond-vm-common v0.1.2
	github.com/gin-gonic/gin v1.3.0
	github.com/prometheus/common v0.4.1
	github.com/stretchr/testify v1.4.0
	github.com/urfave/cli v1.20.0
)

replace github.com/ElrondNetwork/elrond-go => github.com/ElrondNetwork/elrond-go v0.0.0-20191125170548-29f8f6eb0293

replace github.com/ElrondNetwork/elrond-vm => github.com/ElrondNetwork/elrond-vm v0.0.20

replace github.com/ElrondNetwork/elrond-vm-common => github.com/ElrondNetwork/elrond-vm-common v0.1.2

replace github.com/ElrondNetwork/arwen-wasm-vm => github.com/ElrondNetwork/arwen-wasm-vm v0.0.0-20191126122935-dbed20ded116
