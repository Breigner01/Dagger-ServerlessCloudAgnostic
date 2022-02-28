package Azure

import (
    "github.com/AzureServerless/Azure/Login"
    "github.com/AzureServerless/Azure/ResourceGroup"
    "github.com/AzureServerless/Azure/Storage"
    "github.com/AzureServerless/Azure/FunctionApp"
)

#Azure: {

    #Login: Login

    #ResourceGroup: ResourceGroup.#ResourceGroup

    #Storage: Storage.#Storage

    #FunctionApp: FunctionApp.#FunctionApp
}