package AzureServerless

import (
    "github.com/barbo69/AzureServerless/RessourceGroup"
    "github.com/barbo69/AzureServerless/Storage"
    "github.com/barbo69/AzureServerless/Function"
)

#deploy: {
    ressourceGroup: RessourceGroup.#ResourceGroup

    storage: Storage.#StorageAccount & {
        "ressourceGroup": name: ressourceGroup.name
        location: ressourceGroup.location
    }

    function: Function.#function & {
        location: ressourceGroup.location
        "ressourceGroup": name: ressourceGroup.name
        storage: name: storage.name
    }
}