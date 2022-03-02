package globalGcpTest

import (
    "github.com/gcpServerless/configServerless"
    "github.com/global/config"
    "github.com/global/function"
)

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