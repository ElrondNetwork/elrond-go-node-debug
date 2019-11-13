module github.com/ElrondNetwork/elrond-go-node-debug

go 1.12

require (
	github.com/ElrondNetwork/arwen-wasm-vm v0.2.6
	github.com/ElrondNetwork/elrond-go v0.0.0-20191112095930-5fdc115c664c
	github.com/ElrondNetwork/elrond-vm-common v0.1.1
	github.com/gin-gonic/gin v1.3.0
	github.com/stretchr/testify v1.4.0
	github.com/urfave/cli v1.20.0
)

replace github.com/ElrondNetwork/elrond-go => github.com/ElrondNetwork/elrond-go v0.0.0-20191112095930-5fdc115c664c

replace github.com/ElrondNetwork/arwen-wasm-vm => github.com/ElrondNetwork/arwen-wasm-vm v0.0.0-20191113091537-2986be23e6e1
