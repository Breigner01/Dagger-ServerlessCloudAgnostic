package config

import (
	"github.com/gcpServerless/configServerless"
	"github.com/github.com/AzureServerless/"
)

#Config: {
	// The config coming from one of the serverless package
	config: configServerless.#Config | AzureServerless.#Config

	provider: "gcp" | "azure"

	// Need to be improve
	if (provider & "azure") != _|_ {
		config.#Config {
			"function": "args": [
				"--runtime", "node",
				"--runtime-version", "14",
				"--functions-version", "4"
				]
    		"version": "3.0"
		}
	}
}
