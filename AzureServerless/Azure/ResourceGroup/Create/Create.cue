package Create

import (
	"strings"
	"alpha.dagger.io/dagger"
	"alpha.dagger.io/os"
	"github.com/AzureServerless/Azure/Login"
)

// Create a resource group
#Create: {
	// Azure Config
	config: Login.#Config

	// Azure version
	version: string

	// ResourceGroup name
	name: string & dagger.#Input

	// ResourceGroup location
	location: string & dagger.#Input

	// ResourceGroup Id
	id: string & dagger.#Output

	// Additional arguments
    args: [...string] | *[""]

	// Container image
	ctr: os.#Container & {
		image: Login.#CLI & {
			"config": config,
			"version": version
		}

		always: true

		command: #"""
			az group create \
			-l "$AZURE_DEFAULTS_LOCATION" \
			-n "$AZURE_DEFAULTS_GROUP"\
			$ARGS
			az group show -n "$AZURE_DEFAULTS_GROUP" \
			--query "id" -o json | jq -r . | tr -d "\n" > /resourceGroupId
			"""#

		env: {
			AZURE_DEFAULTS_GROUP:    name
			AZURE_DEFAULTS_LOCATION: location
			ARGS: strings.Join(args, " ")
		}
	}

	id: ({
		os.#File & {
			from: ctr
			path: "/resourceGroupId"
		}
	}).contents
}