package FunctionApp

import (
    "universe.dagger.io/docker"
	"github.com/AzureServerless/Azure/Login"
)

#Create: {
    // Azure Config
	config: Login.#Config

    // Azure FonctionApp version
	version: string

    // Function name
    name: string

    // Function location
    location: string 

    // ResourceGroup name
    resourceGroup: name: string

    // Storage name
    storage: name: string

    // Additional arguments
    args: [...string] | *[]

    _image: Login.#Image & {
		"config": config
	}

    docker.#Run & {
		"input": _image.output
		"command": {
			"name": "az"
			"flags": {
				"functionapp": true
				"create": true
				"--resource-group": resourceGroup.name
				"--consumption-plan-location": location
                "--name": name
                "--storage-account": storage.name
                "--functions-version": version
			}
			"args": args
		}
	}
}