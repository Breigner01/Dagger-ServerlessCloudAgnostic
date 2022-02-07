package Azure

import (
    "github.com/barbo69/AzureServerless/Azure/Login"
    "github.com/barbo69/AzureServerless/Azure/ResourceGroup"
    "github.com/barbo69/AzureServerless/Azure/Storage"
    "github.com/barbo69/AzureServerless/Azure/FunctionApp"
)

#azure: {

    #login: Login

    #resourceGroup: ResourceGroup.#resourceGroup

    #storage: Storage.#storage

    #functionApp: FunctionApp.#functionApp

}