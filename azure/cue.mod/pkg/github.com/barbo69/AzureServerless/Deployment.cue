package AzureServerless

import (
    "alpha.dagger.io/dagger"
    "github.com/barbo69/AzureServerless/Azure"
    "github.com/barbo69/AzureServerless/AzureFuncCoreTool"
)

#Config : {
    "login": Azure.#Azure.#Login.#Config

    // Azure version
    "version": string

    // Azure server location
    "location": string & dagger.#Input

    // Azure ressource group name
    "resourceGroup": "name": string & dagger.#Input

    // Azure storage name
    "storage": "name": string & dagger.#Input

    // Azure function name
    "function": "name": string & dagger.#Input

    // Azure function name
    "function": "args": [...string] | *[""]

    // Source directory
    "source": dagger.#Artifact & dagger.#Input

}

#Deploy: {

    config: #Config

    resourceGroup: Azure.#Azure.#ResourceGroup.#Create & {
        "version": config.version
        "name": config.resourceGroup.name
        "location": config.location
        "config": config.login
    }

    if resourceGroup.id != _|_ {
        storage: Azure.#Azure.#Storage.#Account.#Create & {
            "version": config.version
            "config": config.login
            "resourceGroup": name: resourceGroup.name
            "location": resourceGroup.location
            "name": config.storage.name
        }
        if storage.id != _|_ {
            function: Azure.#Azure.#FunctionApp.#Create & {
                "version": config.version
                "config": config.login
                "location": resourceGroup.location
                "resourceGroup": name: resourceGroup.name
                "storage": name: storage.name
                "name": config.function.name
                "args": config.function.args
            }
            if function.id != _|_ {
                funcCoreTool: AzureFuncCoreTool.#AzureFuncCoreTool & {
                    "version": config.version
                    "config": config.login
                    "name": config.function.name
                    "source": config.source
                }
            }
        }
    }
}