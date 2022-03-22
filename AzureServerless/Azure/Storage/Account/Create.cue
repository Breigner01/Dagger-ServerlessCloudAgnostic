package Account

import (
	"universe.dagger.io/docker"
    "github.com/AzureServerless/Azure/Login"
)

// Create a storage account
#Create: {
	// Azure Config
	config: Login.#Config

	// Azure Config
	version: string

	// ResourceGroup name
	resourceGroup: name: string

	// StorageAccount location
	location: string

	// StorageAccount name
	name: string

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
				"storage": true
				"account": true
				"create": true
				"-n": name
				"-g": resourceGroup.name
				"-l": location
				
			}
			"args": args
		}
	}
}