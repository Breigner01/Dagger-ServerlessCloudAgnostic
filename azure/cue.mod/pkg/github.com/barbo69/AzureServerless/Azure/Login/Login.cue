// Azure base package
package Login

import (
	"alpha.dagger.io/dagger"
	"alpha.dagger.io/docker"
	"alpha.dagger.io/os"
)

// Default Azure CLI version
let defaultVersion = "3.0"

#Config: {
	// AZURE subscription id
	subscriptionId: dagger.#Secret & dagger.#Input
}

// Azure Cli to be used by all Azure packages
#CLI: {
	// Azure Config
	config: #Config

	// Azure CLI version to install
	version: string | *defaultVersion

	// Container image
	os.#Container & {
		image: docker.#Pull & {
			from: "barbo69/dagger-azure-cli:\(version)"
		}

		always: true

		command: """
			az login
			az account set -s "$(cat /run/secrets/subscriptionId)"
			"""
		
		secret: {
			"/run/secrets/subscriptionId": config.subscriptionId
		}
	}
}
