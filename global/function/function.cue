package function

import (
	"dagger.io/dagger"
	"github.com/global/config"
	gcpFunction "github.com/gcpServerless/function"
	"github.com/azureServerless"
	//awsServerless "github.com/grouville/dagger-serverless/serverless"
	//"github.com/grouville/dagger-serverless/serverless/events"
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
	//| {
	//    configFunction: provider: "aws"
	//    function: awsServerless.#Function & {
	//        "runtime": runtime + runtimeVersion
	//        code: awsServerless.#Code & {
	//            "name": name
	//            "config": configFunction.awsConfig
	//            "source": source
	//        }
	//        "events": {
	//            "api": events.#Api & {
	//                "path": "/" + name
	//            }
	//        }
	//    }
	//}
}