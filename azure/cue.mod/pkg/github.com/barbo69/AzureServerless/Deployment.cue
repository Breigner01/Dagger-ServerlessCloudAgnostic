package AzureServerless

import (
    "alpha.dagger.io/dagger"
    "github.com/barbo69/AzureServerless/Azure"
    "github.com/barbo69/AzureServerless/AzureFuncCoreTool"
)

#config : {
    "login": Azure.#azure.#login.#Config

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

#deploy: {

    config: #config

    resourceGroup: Azure.#azure.#resourceGroup.#create & {
        "version": config.version
        "name": config.resourceGroup.name
        "location": config.location
        "config": config.login
    }

    if resourceGroup.id != _|_ {
        storage: Azure.#azure.#storage.#account.#create & {
            "version": config.version
            "config": config.login
            "resourceGroup": name: resourceGroup.name
            "location": resourceGroup.location
            "name": config.storage.name
        }
        if storage.id != _|_ {
            function: Azure.#azure.#functionApp.#create & {
                "version": config.version
                "config": config.login
                "location": resourceGroup.location
                "resourceGroup": name: resourceGroup.name
                "storage": name: storage.name
                "name": config.function.name
                "args": config.function.args
            }
            if function.id != _|_ {
                funcCoreTool: AzureFuncCoreTool.#azureFuncCoreTool & {
                    "version": config.version
                    "config": config.login
                    "name": config.function.name
                    "source": config.source
                }
            }
        }
    }
}