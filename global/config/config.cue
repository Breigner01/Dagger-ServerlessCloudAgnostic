package config

import (
	"github.com/gcpServerless/configServerless"
	"github.com/azure/Login"
)

#Config: {
	// The config coming from one of the serverless package
	config: configServerless.#Config | Login.#CLI

	provider: "gcp" | "azure"

	// This one is necessary only in case azure is used so it's created only in this case
	if (provider & "azure") != _|_ {
		azureConfig: Login.#Config
	}
}
