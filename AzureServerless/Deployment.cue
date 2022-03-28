package AzureServerless

import (
    "dagger.io/dagger"
	"github.com/AzureServerless/Azure/Login"
	"github.com/AzureServerless/Azure/RessourceGroup"
	"github.com/AzureServerless/Azure/Storage/Account"
	"github.com/AzureServerless/Azure/FunctionApp"
	"github.com/AzureServerless/AzureFuncCoreTool"
)

#Config: {

	// Azure login
    login: Login.#Config

    // Azure server location
    location: string

    // Azure ressource group name
    resourceGroup: name: string

    // Azure storage name
    storage: name: string

    // Azure functionApp name
    functionApp: name: string

    // Azure functionApp name
    functionApp: version: string | *"4"

    // Azure functionApp args
    functionApp: args: [...string] | *[]

	// Azure publish function args
    publishFunction: args: [...string] | *[]

}

#Deploy: {

    // Source directory
    source: dagger.#FS

    config: #Config

	login: Login.#Image & {
		"config": config.login
	}

    createRessourceGroup: RessourceGroup.#Create & {
		"image": login.output
		"name": config.resourceGroup.name
		"location": config.location
	}
	createStorageAccount: Account.#Create & {
		"image": createRessourceGroup.output
		"resourceGroup": "name": config.resourceGroup.name
		"name": config.storage.name
		"location": config.location
	}
	createFunctionApp: FunctionApp.#Create & {
		"image": createStorageAccount.output
		"resourceGroup": "name": config.resourceGroup.name
		"storage": "name": config.storage.name 
		"name": config.functionApp.name
		"location": config.location
		"version": config.functionApp.version
		"args": config.functionApp.args
	}
	publishFunction: AzureFuncCoreTool.#Publish & {
		"image": createFunctionApp.output
		"name": config.functionApp.name
		"source": source
		"args": config.publishFunction.args
	}
}