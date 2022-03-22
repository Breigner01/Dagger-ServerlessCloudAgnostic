package AzureServerlessTest

import (
	"dagger.io/dagger"
	"github.com/AzureServerless/Azure/RessourceGroup"
	"github.com/AzureServerless/Azure/Login"
)

dagger.#Plan & {

	client: env: AZ_SUB_ID_TOKEN: dagger.#Secret

	actions: login: RessourceGroup.#Create & {
		config: Login.#Config & {
			subscriptionId: client.env.AZ_SUB_ID_TOKEN
		}

		version: "3.0"

		name: "test1212121"

		location: "northeurope"
	}
}