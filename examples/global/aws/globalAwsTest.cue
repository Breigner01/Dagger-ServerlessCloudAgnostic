package globalAwsTest

import (
    "encoding/json"
    "alpha.dagger.io/dagger"
    "alpha.dagger.io/aws"
    "github.com/global/config"
    "github.com/global/function"
)

awsConfig: config.#Config & {
    "awsConfig": aws.#Config & {
        region: "eu-west-3"
    }
}

awsFunction: function.#Function & {
    configFunction: awsConfig
    runtime: "go"
    runtimeVersion: "1.x"
    name: "HelloWorld"
}

output: dagger.#Output & {json.Marshal(awsFunction.function.#manifest)}