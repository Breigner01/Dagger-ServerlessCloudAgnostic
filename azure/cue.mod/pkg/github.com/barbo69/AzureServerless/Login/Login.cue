// Azure base package
package Login

import (
	"alpha.dagger.io/docker"
	"alpha.dagger.io/os"
)

// Default Azure CLI version
let defaultVersion = "2.27.1@sha256:1e117183100c9fce099ebdc189d73e506e7b02d2b73d767d3fc07caee72f9fb1"

// Azure Cli to be used by all Azure packages
#CLI: {

	// Azure CLI version to install
	version: string | *defaultVersion

	// Container image
	os.#Container & {
		image: docker.#Pull & {
			from: "mcr.microsoft.com/azure-cli:\(version)"
		}

		always: true

		command: """
			az login
			"""
	}
}
