package Azure

import (
    "github.com/barbo69/AzureServerless/Azure/Login"
    "github.com/barbo69/AzureServerless/Azure/ResourceGroup"
    "github.com/barbo69/AzureServerless/Azure/Storage"
    "github.com/barbo69/AzureServerless/Azure/FunctionApp"
)

#Azure: {

    #Login: Login

    #ResourceGroup: ResourceGroup.#ResourceGroup

    #Storage: Storage.#Storage

    #FunctionApp: FunctionApp.#FunctionApp
}