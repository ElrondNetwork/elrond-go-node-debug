module github.com/ElrondNetwork/elrond-go-node-debug

go 1.13

require (
	github.com/ElrondNetwork/arwen-wasm-vm v0.3.8-0.20200309094135-486bb8f2fd8b
	github.com/ElrondNetwork/elrond-go v1.0.90-0.20200309072532-9a90e47c028c
	github.com/ElrondNetwork/elrond-vm-common v0.1.12
	github.com/gin-gonic/gin v1.3.0
	github.com/prometheus/common v0.4.1
	github.com/stretchr/testify v1.4.0
	github.com/urfave/cli v1.20.0
	go.dedis.ch/kyber/v3 v3.0.12 // indirect
)

replace github.com/ElrondNetwork/elrond-go => github.com/ElrondNetwork/elrond-go v0.0.0-20200309072532-9a90e47c028c

replace github.com/ElrondNetwork/arwen-wasm-vm => github.com/ElrondNetwork/arwen-wasm-vm v0.0.0-20200309094135-486bb8f2fd8b
