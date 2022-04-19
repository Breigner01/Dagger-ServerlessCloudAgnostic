package config

import (
	"github.com/gcp/gcr"
	"github.com/azureServerless"
)

#Config: {
	// The config coming from one of the serverless package
	gcpConfig: gcr.#Credentials | *null

	azureConfig: azureServerless.#Config | *null

	provider: "gcp" | "azure"
}
