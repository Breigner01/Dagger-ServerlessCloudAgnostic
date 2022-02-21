package function

import (
    gcpConfig "github.com/gcpServerless/configServerless"
    "github.com/azure/Login"
	"github.com/global/config"
	gcpFunction "github.com/gcpServerless/function"
	azureFunction "github.com/azure/FunctionApp/Create"
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
    source: string & dagger.#Input

    if (configFunction.provider & "gcp") != _|_ {
        function: gcpFunction.#Function & {
            "config": configFunction.config
            "name": name
            "runtime": runtime + runtimeVersion
            "source": source
        }
    }

    if (configFunction.provider & "azure") != _|_ {
        function: azureFunction.#create & {
            
        }
    }
}
