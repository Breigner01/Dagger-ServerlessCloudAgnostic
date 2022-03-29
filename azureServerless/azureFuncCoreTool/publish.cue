package azureFuncCoreTool

import (
	"dagger.io/dagger"
	"universe.dagger.io/docker"
)

#Publish: {

	image: docker.#Image

    // Function name
	name: string

    // Source directory
    source: dagger.#FS

	// Additional arguments
    args: [...string] | *[]

	sleep: {
		"isSleep": bool | *false
		"sleepTime": string | *""
	}

	docker.#Build & {
		steps: [
			if sleep.isSleep == true {
				dockerSleep: docker.#Run & {
					"input": image
					"command": {
						"name": "sleep"
						"flags": {
							"\(sleep.sleepTime)": true
						}
					}
				},
			},
			docker.#Run & {
				"input": image
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
		]
	}	
}