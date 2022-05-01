package azureServerless

import (
    "dagger.io/dagger"
	azLogin "github.com/azureServerless/azure/login"
	"github.com/azureServerless/azure/resourceGroup"
	"github.com/azureServerless/azure/storage/account"
	"github.com/azureServerless/azure/functionApp"
	"github.com/azureServerless/azureFuncCoreTool"
)

#Config: {

	// Azure login
    login: azLogin.#Config

    // Azure server location
    location: string

    // Azure ressource group name
    resourceGroup: name: string

    // Azure storage name
    storage: name: string

    // Azure functionApp name
    functionApp: name: string

    // Azure functionApp version
    functionApp: version: string | *"4"

    // Azure functionApp args
    functionApp: args: [...string] | *[]

	// Azure publish function args
    publishFunction: args: [...string] | *[]

	// Azure publish function sleep time before exec
    publishFunction: sleep: string

	// Sleep time default value
	if publishFunction.sleep == _|_ {
		publishFunction: sleep: "30"
	}
}

#Deploy: {

    // Source directory
    source: dagger.#FS

    config: #Config

	login: azLogin.#Image & {
		"config": config.login
	}

    createRessourceGroup: resourceGroup.#Create & {
		"image": login.output
		"name": config.resourceGroup.name
		"location": config.location
	}
	createStorageAccount: account.#Create & {
		"image": createRessourceGroup.output
		"resourceGroup": "name": config.resourceGroup.name
		"name": config.storage.name
		"location": config.location
	}
	createFunctionApp: functionApp.#Create & {
		"image": createStorageAccount.output
		"resourceGroup": "name": config.resourceGroup.name
		"storage": "name": config.storage.name 
		"name": config.functionApp.name
		"location": config.location
		"version": config.functionApp.version
		"args": config.functionApp.args
	}
	publishFunction: azureFuncCoreTool.#Publish & {
		"image": createFunctionApp.output
		"name": config.functionApp.name
		"source": source
		"args": config.publishFunction.args
		"sleep": config.publishFunction.sleep
	}
}