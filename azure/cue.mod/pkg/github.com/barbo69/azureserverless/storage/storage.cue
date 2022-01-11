package storage

import (
    "github.com/barbo69/azureserverless/login"
    "alpha.dagger.io/os"
	"alpha.dagger.io/dagger"
)

// Create a storage account
#StorageAccount: {

	// ResourceGroup name
	rgName: string & dagger.#Input

	// StorageAccount location
	stLocation: string & dagger.#Input

	// StorageAccount name
	stName: string & dagger.#Input

	// StorageAccount Id
	id: string & dagger.#Output

	// Container image
	ctr: os.#Container & {
		image: login.#CLI
		always: true

		command: """
			az storage account create -n "$AZURE_STORAGE_ACCOUNT" -g "$AZURE_DEFAULTS_GROUP" -l "$AZURE_DEFAULTS_LOCATION"
			az storage account show -n "$AZURE_STORAGE_ACCOUNT" -g "$AZURE_DEFAULTS_GROUP" --query "id" -o json | jq -r . | tr -d "\n" > /storageAccountId
			"""

		env: {
			AZURE_DEFAULTS_GROUP:    rgName
			AZURE_DEFAULTS_LOCATION: stLocation
			AZURE_STORAGE_ACCOUNT:   stName
		}
	}

	// StorageAccount Id
	id: ({
		os.#File & {
			from: ctr
			path: "/storageAccountId"
		}
	}).contents
}