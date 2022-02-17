package Create

import (
	"strings"
	"alpha.dagger.io/dagger"
	"alpha.dagger.io/os"
    "github.com/barbo69/AzureServerless/Azure/Login"
)

// Create a storage account
#Create: {
	// Azure Config
	config: Login.#Config

	// Azure Config
	version: string

	// ResourceGroup name
	resourceGroup: name: string & dagger.#Input

	// StorageAccount location
	location: string & dagger.#Input

	// StorageAccount name
	name: string & dagger.#Input

	// StorageAccount Id
	id: string & dagger.#Output

	// Additional arguments
    args: [...string] | *[""]

	// Container image
	ctr: os.#Container & {
		image: Login.#CLI & {
			"config": config
			"version": version
		}
		always: true

		command: #"""
			az storage account \
			create -n "$AZURE_STORAGE_ACCOUNT" \
			-g "$AZURE_DEFAULTS_GROUP" \
			-l "$AZURE_DEFAULTS_LOCATION" \
			$ARGS
			az storage account show \
			-n "$AZURE_STORAGE_ACCOUNT" \
			-g "$AZURE_DEFAULTS_GROUP" \--query "id" -o json | jq -r . | tr -d "\n" > /storageAccountId
			"""#

		env: {
			AZURE_DEFAULTS_GROUP:    resourceGroup.name
			AZURE_DEFAULTS_LOCATION: location
			AZURE_STORAGE_ACCOUNT:   name
			ARGS: strings.Join(args, " ")
		}
	}

	id: ({
		os.#File & {
			from: ctr
			path: "/storageAccountId"
		}
	}).contents
}