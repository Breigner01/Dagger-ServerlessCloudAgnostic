package configServerless

import (
	"alpha.dagger.io/gcp"
	"alpha.dagger.io/gcp/gcr"
)

#Config: {
	configGcp: gcp.#Config

	credentials: gcr.#Credentials & {
		config: configGcp
	}
}
