module github.com/ElrondNetwork/elrond-go-node-debug

go 1.12

require (
	github.com/ElrondNetwork/arwen-wasm-vm v0.3.4
	github.com/ElrondNetwork/elrond-go v0.0.0
	github.com/ElrondNetwork/elrond-vm-common v0.1.10
	github.com/gin-gonic/gin v1.3.0
	github.com/prometheus/common v0.4.1
	github.com/stretchr/testify v1.4.0
	github.com/urfave/cli v1.20.0
)

replace github.com/ElrondNetwork/elrond-go => github.com/ElrondNetwork/elrond-go v0.0.0-20200211084225-6106693b6059

replace github.com/ElrondNetwork/arwen-wasm-vm => github.com/ElrondNetwork/arwen-wasm-vm v0.0.0-20200211094152-2d1e2cc4572b
