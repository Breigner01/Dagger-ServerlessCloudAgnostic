package config

import (
	"github.com/gcpServerless/configServerless"
	"github.com/azureServerless"
)

#Config: {
	// The config coming from one of the serverless package
	gcpConfig: configServerless.#Config | *null

	azureConfig: azureServerless.#Config | *null

	provider: "gcp" | "azure"
}
