package AzureFuncCoreTool

import (
	"dagger.io/dagger"
	"universe.dagger.io/docker"
	"github.com/AzureServerless/Azure/Login"
)

#Publish: {

    // Azure Config
	config: Login.#Config

    // Function name
	name: string

    // Source directory
    source: dagger.#FS

	// Additional arguments
    args: [...string] | *[]

	_image: Login.#Image & {
		"config": config
	}

	docker.#Run & {
		"input": _image.output
		"workdir": "/src"
		"command": {
			"name": "func"
			"flags": {
				"azure": true
				"functionapp": true
				"publish": name
			}
			"args": args
		}
		mounts: {
			"source": {
				dest:     "/src"
				contents: source
			}
		}
	}	
}