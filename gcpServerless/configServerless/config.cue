package configServerless

import (
	"github.com/gcp"
	"github.com/gcp/gcr"
)

#Config: {
	gcpConfig:   gcp.#Config
	credentials: gcr.#Credentials & {
		config: gcpConfig
	}
}
