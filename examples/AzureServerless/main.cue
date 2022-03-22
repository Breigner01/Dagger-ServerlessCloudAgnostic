package AzureServerlessTest

import (
	"dagger.io/dagger"
	"github.com/AzureServerless/Azure/Login"
	"github.com/AzureServerless/Azure/RessourceGroup"
	"github.com/AzureServerless/Azure/Storage/Account"
	"github.com/AzureServerless/Azure/FunctionApp"
)

dagger.#Plan & {

	client: env: AZ_SUB_ID_TOKEN: dagger.#Secret

	actions: {
		"CreateRessourceGroup": RessourceGroup.#Create & {
			config: Login.#Config & {
				subscriptionId: client.env.AZ_SUB_ID_TOKEN
			}
			name: "test1212121"
			location: "northeurope"
		}
		"CreateStorageAccount": Account.#Create & {
			config: Login.#Config & {
				subscriptionId: client.env.AZ_SUB_ID_TOKEN
			}
			resourceGroup: name: "test1212121"
			name: "ajajkaj"
			location: "northeurope"
		}
		"CreateFunctionApp": FunctionApp.#Create & {
			config: Login.#Config & {
				subscriptionId: client.env.AZ_SUB_ID_TOKEN
			}
			resourceGroup: name: "test1212121"
			storage: name: "ajajkaj" 
			name: "ajajkaj"
			location: "northeurope"
			version: "3"
		}
	} 	
}