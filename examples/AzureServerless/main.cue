package AzureServerlessTest

import (
	"dagger.io/dagger"
	"github.com/AzureServerless/Azure/Login"
	"github.com/AzureServerless/Azure/RessourceGroup"
	"github.com/AzureServerless/Azure/Storage/Account"
	"github.com/AzureServerless/Azure/FunctionApp"
	"github.com/AzureServerless/AzureFuncCoreTool"
)

dagger.#Plan & {

	client: {
		env: AZ_SUB_ID_TOKEN: dagger.#Secret
	
		filesystem: "./deploy_function": read: contents: dagger.#FS
	}

	actions: {
		"CreateRessourceGroup": RessourceGroup.#Create & {
			config: Login.#Config & {
				subscriptionId: client.env.AZ_SUB_ID_TOKEN
			}
			name: "ressourceGroupTest"
			location: "northeurope"
		}
		"CreateStorageAccount": Account.#Create & {
			config: Login.#Config & {
				subscriptionId: client.env.AZ_SUB_ID_TOKEN
			}
			resourceGroup: name: "ressourceGroupTest"
			name: "storage2test2"
			location: "northeurope"
		}
		"CreateFunctionApp": FunctionApp.#Create & {
			config: Login.#Config & {
				subscriptionId: client.env.AZ_SUB_ID_TOKEN
			}
			resourceGroup: name: "ressourceGroupTest"
			storage: name: "storage2test2" 
			name: "function2App2Test"
			location: "northeurope"
			version: "4"
			args: ["--runtime", "node", "--runtime-version", "14"]
		}
		"Publishfunction": AzureFuncCoreTool.#Publish & {
			config: Login.#Config & {
				subscriptionId: client.env.AZ_SUB_ID_TOKEN
			}
			name: "function2App2Test"
			source: client.filesystem."./deploy_function".read.contents
		}
	} 	
}