package RessourceGroup

import (
	"universe.dagger.io/docker"
	"github.com/AzureServerless/Azure/Login"
)

#Create: {
	// Azure Config
	config: Login.#Config

	// ResourceGroup name
	name: string

	// ResourceGroup location
	location: string

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
				"group": true
				"create": true
				"-l": location
				"-n": name
			}
			"args": args
		}
	}
}
