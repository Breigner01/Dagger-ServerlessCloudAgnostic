package AzureServerless

import (
    "github.com/barbo69/AzureServerless/Login"
    "github.com/barbo69/AzureServerless/RessourceGroup"
    "github.com/barbo69/AzureServerless/Storage"
    "github.com/barbo69/AzureServerless/Function"
)

#deploy: {
    config: Login.#Config

    ressourceGroup: RessourceGroup.#ResourceGroup & {
        "config": config
    }

    storage: Storage.#StorageAccount & {
        "config": config
        "ressourceGroup": name: ressourceGroup.name
        "location": ressourceGroup.location
    }

    function: Function.#function & {
        "config": config
        "location": ressourceGroup.location
        "ressourceGroup": name: ressourceGroup.name
        "storage": name: storage.name
    }
}