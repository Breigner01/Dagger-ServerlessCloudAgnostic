package function

import (
	"dagger.io/dagger"
	"github.com/global/config"
	gcpFunction "github.com/gcp/function"
	"github.com/azureServerless"
)

#Function: {
	// The configuration instantiated using the config of the global package
	configFunction: config.#Config

	// The name of the binary used to run the serverless function
	runtime: string

	runtimeVersion: string

	// The name of the function
	name: string

	// The path to the folder containing the file with the function
	source: dagger.#FS

	{
		configFunction: provider: "gcp"
		function: gcpFunction.#Function & {
			"config": configFunction.gcpConfig
			"name": name
			"runtime": runtime + runtimeVersion
			"source": source
		}
	} | {
		configFunction: provider: "azure"
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