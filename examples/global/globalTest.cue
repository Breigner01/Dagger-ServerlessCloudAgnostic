package globalTest

import (
    "github.com/AzureServerless"
    "github.com/global/config"
    "github.com/global/function"
)

configAzure: config.#Config & {
    azureConfig: AzureServerless.#Config
    provider: "azure"
}

functionAzure: function.#Function & {
    configFunction: configAzure
    runtime: "node"
    runtimeVersion: "14"
    name: "test"
}