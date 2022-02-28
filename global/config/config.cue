package config

import (
	"github.com/gcpServerless/configServerless"
	"github.com/AzureServerless"
)

#Config: {
	// The config coming from one of the serverless package
	gcpConfig: configServerless.#Config | *null

	azureConfig: AzureServerless.#Config | *null

	provider: "gcp" | "azure"
}
