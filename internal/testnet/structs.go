package testnet

import "math/big"

import vmcommon "github.com/ElrondNetwork/elrond-vm-common"

type addressResource struct {
	Account *accountResource `json:"account"`
	Error   string           `json:"error"`
}

type accountResource struct {
	Address string `json:"address"`
	Nonce   uint64 `json:"nonce"`
}

// SendTransactionResponse is a REST response object
type SendTransactionResponse struct {
	Message string                          `json:"message"`
	Error   string                          `json:"error"`
	TxHash  string                          `json:"txHash,omitempty"`
	TxResp  *SendTransactionResponsePayload `json:"transaction,omitempty"`
}

// SendTransactionResponsePayload is a REST response object (substructure)
type SendTransactionResponsePayload struct {
	Sender      string   `form:"sender" json:"sender"`
	Receiver    string   `form:"receiver" json:"receiver"`
	Value       *big.Int `form:"value" json:"value"`
	Data        string   `form:"data" json:"data"`
	Nonce       uint64   `form:"nonce" json:"nonce"`
	GasPrice    uint64   `form:"gasPrice" json:"gasPrice"`
	GasLimit    uint64   `form:"gasLimit" json:"gasLimit"`
	Signature   string   `form:"signature" json:"signature"`
	Challenge   string   `form:"challenge" json:"challenge"`
	ShardID     uint32   `json:"shardId"`
	Hash        string   `json:"hash"`
	BlockNumber uint64   `json:"blockNumber"`
	BlockHash   string   `json:"blockHash"`
	Timestamp   uint64   `json:"timestamp"`
}

// SCQueryRequest is a REST request object
type SCQueryRequest struct {
	ScAddress string   `form:"scAddress" json:"scAddress"`
	FuncName  string   `form:"funcName" json:"funcName"`
	Args      []string `form:"args"  json:"args"`
}

// SCQueryResponse is a REST response object
type SCQueryResponse struct {
	Error string            `json:"error"`
	Data  vmcommon.VMOutput `json:"data"`
}
