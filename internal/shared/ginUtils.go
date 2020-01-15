package shared

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

// ReturnBadRequest returns a "bad request" response
func ReturnBadRequest(context *gin.Context, errScope string, err error) {
	message := fmt.Sprintf("%s: %s", errScope, err)
	context.JSON(http.StatusBadRequest, gin.H{"error": message})
}

// ReturnOkResponse returns an "ok" response
func ReturnOkResponse(context *gin.Context, data interface{}) {
	context.JSON(http.StatusOK, gin.H{"data": data})
}
