package configServerless

import (
	"alpha.dagger.io/gcp"
	"alpha.dagger.io/gcp/gcr"
)

#Config: {
	gcpConfig:   gcp.#Config
	credentials: gcr.#Credentials & {
		config: gcpConfig
	}
}
