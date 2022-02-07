package AzureServerless

import (
    "alpha.dagger.io/dagger"
    "github.com/barbo69/AzureServerless/Login"
    "github.com/barbo69/AzureServerless/RessourceGroup"
    "github.com/barbo69/AzureServerless/Storage"
    "github.com/barbo69/AzureServerless/Function"
)

#config : {
    login: Login.#Config

    // Azure server location
    location: string & dagger.#Input

    // Azure ressource group name
    ressourceGroup: name: string & dagger.#Input

    // Azure storage name
    storage: name: string & dagger.#Input

    // Azure function name
    function: name: string & dagger.#Input

}

#deploy: {

    config: #config

    ressourceGroup: RessourceGroup.#ResourceGroup & {
        "name": config.ressourceGroup.name
        "location": config.location
        "config": config.login
    }

    if ressourceGroup.id != _|_ {
        storage: Storage.#StorageAccount & {
            "config": config.login
            "ressourceGroup": name: ressourceGroup.name
            "location": ressourceGroup.location
            "name": config.storage.name
        }
        if storage.id != _|_ {
            function: Function.#function & {
                "config": config.login
                "location": ressourceGroup.location
                "ressourceGroup": name: ressourceGroup.name
                "storage": name: storage.name
                "name": config.function.name
            }   
        }
    }
}