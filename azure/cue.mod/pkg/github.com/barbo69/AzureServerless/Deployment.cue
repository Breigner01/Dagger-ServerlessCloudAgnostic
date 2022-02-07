package AzureServerless

import (
    "alpha.dagger.io/dagger"
    "github.com/barbo69/AzureServerless/Azure"
)

#config : {
    "login": Azure.#azure.#login.#Config

    // Azure server location
    "location": string & dagger.#Input

    // Azure ressource group name
    "resourceGroup": "name": string & dagger.#Input

    // Azure storage name
    "storage": "name": string & dagger.#Input

    // Azure function name
    "function": "name": string & dagger.#Input

}

#deploy: {

    config: #config

    resourceGroup: Azure.#azure.#resourceGroup.#create & {
        "name": config.resourceGroup.name
        "location": config.location
        "config": config.login
    }

    if resourceGroup.id != _|_ {
        storage: Azure.#azure.#storage.#account.#create & {
            "config": config.login
            "resourceGroup": name: resourceGroup.name
            "location": resourceGroup.location
            "name": config.storage.name
        }
        if storage.id != _|_ {
            function: Azure.#azure.#functionApp.#create & {
                "config": config.login
                "location": resourceGroup.location
                "resourceGroup": name: resourceGroup.name
                "storage": name: storage.name
                "name": config.function.name
            }   
        }
    }
}