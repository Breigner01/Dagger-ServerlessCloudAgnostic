package globalTest

import (
    "github.com/AzureServerless"
    "github.com/gcpServerless/configServerless"
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


gcpConfig: config.#Config & {
    "gcpConfig": configServerless.#Config
    provider: "gcp"
}

gcpFunction: function.#Function & {
    configFunction: gcpConfig
    runtime: "go"
    runtimeVersion: "116"
    name: "HelloWorld"
}