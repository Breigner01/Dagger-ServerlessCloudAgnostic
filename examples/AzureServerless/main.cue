package AzureServerlessTest

import (
	"dagger.io/dagger"
	"github.com/AzureServerless/Azure/Login"
	"github.com/AzureServerless/Azure/RessourceGroup"
	"github.com/AzureServerless/Azure/Storage/Account"
)

dagger.#Plan & {

	client: env: AZ_SUB_ID_TOKEN: dagger.#Secret

	actions: {
		"CreateRessourceGroup": RessourceGroup.#Create & {
			config: Login.#Config & {
				subscriptionId: client.env.AZ_SUB_ID_TOKEN
			}
			version: "3.0"
			name: "test1212121"
			location: "northeurope"
		}
		"CreateStorageAccount": Account.#Create & {
			config: Login.#Config & {
				subscriptionId: client.env.AZ_SUB_ID_TOKEN
			}
			resourceGroup: name: "test1212121"
			version: "3.0"
			name: "ajajkaj"
			location: "northeurope"
		}
	} 	
}