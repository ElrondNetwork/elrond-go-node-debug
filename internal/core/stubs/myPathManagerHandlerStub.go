package stubs

// MyPathManagerHandlerStub is a stub
type MyPathManagerHandlerStub struct {
}

// PathForEpoch is a stub
func (stub *MyPathManagerHandlerStub) PathForEpoch(shardID string, epoch uint32, identifier string) string {
	return "not-implemented"
}

// PathForStatic is a stub
func (stub *MyPathManagerHandlerStub) PathForStatic(shardID string, identifier string) string {
	return "not-implemented"
}

// IsInterfaceNil is a stub
func (stub *MyPathManagerHandlerStub) IsInterfaceNil() bool {
	return false
}
