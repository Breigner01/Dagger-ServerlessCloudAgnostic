package RessourceGroup

import (
	"universe.dagger.io/docker"
	"github.com/AzureServerless/Azure/Login"
)

#Create: {
	// Azure Config
	config: Login.#Config

	// Azure version
	version: string

	// ResourceGroup name
	name: string

	// ResourceGroup location
	location: string

	// Additional arguments
    args: [...string] | *[]

	_image: Login.#Image & {
		"config": config
		"version": version
	}

	docker.#Run & {
		"input": _image.output
		"command": {
			"name": "az"
			"flags": {
				"group": "create"
				"-l": location
				"-n": name
			}
			"args": args
		}
	}
}
