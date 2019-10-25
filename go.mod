module github.com/ElrondNetwork/elrond-go-node-debug

go 1.12

require (
	github.com/ElrondNetwork/elrond-go v1.0.18-0.20190925090404-cc062628fc67
	github.com/ElrondNetwork/elrond-vm-common v0.0.8
	github.com/gin-gonic/gin v1.3.0
	github.com/stretchr/testify v1.3.0
	github.com/urfave/cli v1.20.0
)

replace github.com/ElrondNetwork/elrond-go v1.0.18 => github.com/ElrondNetwork/elrond-go v0.0.0-20191025090552-fa9a4087424a39a8a5245bbbd5c91e1fddaf05d5
replace github.com/ElrondNetwork/arwen-wasm-vm v0.1.0 => github.com/ElrondNetwork/arwen-wasm-vm v0.0.9-0.20191016093011-2ff76585ab63
