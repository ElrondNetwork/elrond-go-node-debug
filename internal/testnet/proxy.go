package testnet

import (
	"bytes"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"

	"github.com/ElrondNetwork/elrond-go/marshal"
	vmcommon "github.com/ElrondNetwork/elrond-vm-common"
)

// Proxy is a testnet proxy
type Proxy struct {
	URL string
}

// NewProxy creates a testnet proxy
func NewProxy(url string) *Proxy {
	return &Proxy{URL: url}
}

// GetNonce gets the nonce by address
func (proxy *Proxy) GetNonce(addressBytes []byte) (uint64, error) {
	addressEncoded := hex.EncodeToString(addressBytes)
	url := fmt.Sprintf("%s/address/%s", proxy.URL, addressEncoded)
	log.Println("getNonce, perform GET:")
	log.Println(url)
	response, err := http.Get(url)
	if err != nil {
		return 0, err
	}

	defer response.Body.Close()
	body, err := ioutil.ReadAll(response.Body)
	if err != nil {
		return 0, err
	}

	fmt.Println("Response:")
	fmt.Println(string(body))
	address := addressResource{Account: &accountResource{}}
	err = json.NewDecoder(bytes.NewBuffer(body)).Decode(&address)
	if err != nil {
		return 0, err
	}
	if len(address.Error) > 0 {
		return 0, fmt.Errorf(address.Error)
	}

	nonce := address.Account.Nonce
	fmt.Println("Nonce:")
	fmt.Println(nonce)
	return nonce, err
}

// SendTransaction sends a transaction
func (proxy *Proxy) SendTransaction(txBuff []byte) (*SendTransactionResponse, error) {
	url := fmt.Sprintf("%s/transaction/send", proxy.URL)
	log.Println("sendTransaction, perform POST:")
	log.Println(url)
	log.Println(string(txBuff))

	response, err := http.Post(url, "application/json", bytes.NewBuffer(txBuff))
	if err != nil {
		return nil, err
	}

	defer response.Body.Close()
	body, _ := ioutil.ReadAll(response.Body)
	fmt.Println("Response:")
	fmt.Println(string(body))
	structuredResponse := SendTransactionResponse{}
	err = json.NewDecoder(bytes.NewBuffer(body)).Decode(&structuredResponse)
	if err != nil {
		return nil, err
	}
	if len(structuredResponse.Error) > 0 {
		return nil, fmt.Errorf(structuredResponse.Error)
	}

	return &structuredResponse, nil
}

// QuerySC queries SC values
func (proxy *Proxy) QuerySC(request SCQueryRequest) (*vmcommon.VMOutput, error) {
	url := fmt.Sprintf("%s/vm-values/query", proxy.URL)

	queryBuff, _ := marshal.JsonMarshalizer{}.Marshal(request)
	log.Println("QuerySC, perform POST:")
	log.Println(url)
	log.Println(string(queryBuff))

	response, err := http.Post(url, "application/json", bytes.NewBuffer(queryBuff))
	if err != nil {
		return nil, err
	}

	defer response.Body.Close()
	body, _ := ioutil.ReadAll(response.Body)
	fmt.Println("Response:")
	fmt.Println(string(body))
	structuredResponse := SCQueryResponse{}
	err = json.NewDecoder(bytes.NewBuffer(body)).Decode(&structuredResponse)
	if err != nil {
		return nil, err
	}
	if len(structuredResponse.Error) > 0 {
		return nil, fmt.Errorf(structuredResponse.Error)
	}

	return &structuredResponse.Data, nil
}
