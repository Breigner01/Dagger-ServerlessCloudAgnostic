package RessourceGroup

import (
	"github.com/barbo69/AzureServerless/Login"
	"alpha.dagger.io/os"
	"alpha.dagger.io/dagger"
)

// Create a resource group
#ResourceGroup: {

	// ResourceGroup name
	name: string & dagger.#Input

	// ResourceGroup location
	location: string & dagger.#Input

	// ResourceGroup Id
	id: string & dagger.#Output

	// Container image
	ctr: os.#Container & {
		image: Login.#CLI 

		always: true

		command: """
			az group create -l "$AZURE_DEFAULTS_LOCATION" -n "$AZURE_DEFAULTS_GROUP"
			az group show -n "$AZURE_DEFAULTS_GROUP" --query "id" -o json | jq -r . | tr -d "\n" > /resourceGroupId
			"""

		env: {
			AZURE_DEFAULTS_GROUP:    name
			AZURE_DEFAULTS_LOCATION: location
		}
	}

	// Resource Id
	id: ({
		os.#File & {
			from: ctr
			path: "/resourceGroupId"
		}
	}).contents
}