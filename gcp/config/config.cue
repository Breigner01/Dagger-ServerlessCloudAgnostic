package gcp_serverless

import (
	"alpha.dagger.io/dagger"
	"alpha.dagger.io/gcp"
	"alpha.dagger.io/gcp/gcr"
)

#Config: {
	gcpConfig: gcp, #Config

	credentials: gcr.#Credentials & {
		config: gcpConfig
	}
}
