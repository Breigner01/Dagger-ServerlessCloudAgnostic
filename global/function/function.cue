package function

import (
    "alpha.dagger.io/dagger"
    "github.com/global/config"
	gcpFunction "github.com/gcpServerless/function"
	azureServerless "github.com/AzureServerless"
)

#Function: {
    // The configuration instantiated using the config of the global package
	configFunction: config.#Config

    // The name of the binary used to run the serverless function
    runtime: string

    runtimeVersion: string

    // The name of the function
    name: string
    
    // GCP: The path to the folder containing the file with the function
    // Azure: The path to the file containing the function
    source: dagger.#Artifact & dagger.#Input

    if (configFunction.provider & "gcp") != _|_ {
        function: gcpFunction.#Function & {
            "config": configFunction.gcpConfig
            "name": name
            "runtime": runtime + runtimeVersion
            "source": source
        }
    }

    if (configFunction.provider & "azure") != _|_ {
        function: azureServerless.#Deploy & {
            "config": configFunction.azureConfig & {
                "function": "args": [
                    "--runtime", runtime,
                    "--runtime-version", runtimeVersion,
                    "--functions-version", "3"
                ]
    		    "version": "2.0"
            }
            "source": source
        }
    }
}