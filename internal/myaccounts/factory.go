package myaccounts

import (
	"encoding/hex"
	"fmt"
	"math/big"

	"github.com/ElrondNetwork/elrond-go-node-debug/internal/shared"
	"github.com/ElrondNetwork/elrond-go/data/state"
)

type AccountFactory struct {
}

func (accountFactory *AccountFactory) CreateAccount(address state.AddressContainer, tracker state.AccountTracker) (state.AccountHandler, error) {
	return state.NewAccount(address, tracker)
}

// IsInterfaceNil returns true if there is no value under the interface
func (af *AccountFactory) IsInterfaceNil() bool {
	if af == nil {
		return true
	}
	return false
}

func CreateAccount(accnts state.AccountsAdapter, pubKey []byte, nonce uint64, balance *big.Int) []byte {
	fmt.Printf("CreateAccount %s, balance = %s\n", hex.EncodeToString(pubKey), balance.String())

	address, _ := shared.AddressConverter.CreateAddressFromPublicKeyBytes(pubKey)
	account, _ := accnts.GetAccountWithJournal(address)
	_ = account.(*state.Account).SetNonceWithJournal(nonce)
	_ = account.(*state.Account).AddToBalance(balance)

	hashCreated, _ := accnts.Commit()
	return hashCreated
}
