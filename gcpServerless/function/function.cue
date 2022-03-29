package function

import (
	"dagger.io/dagger"
	"universe.dagger.io/docker"
	"github.com/gcp"
	"github.com/gcpServerless/configServerless"
)

// The runtimes are copied from https://cloud.google.com/functions/docs/concepts/exec
// If the list would come to change please submit an issue or a pull request to integrate it
#Runtime: "nodejs16" | "nodejs14" | "nodejs12" | "nodejs10" | "nodejs8" | "nodejs6" | "python39" | "python38" |
	"python37" | "go116" | "go113" | "go111" | "java11" | "dotnet3" | "ruby27" | "ruby26" | "php74"

#Function: {

	// The Config from gcpServerless/configServerless.#Config
	config: configServerless.#Config
	// The name of the function on gcp, the function developed and the file
	name: string
	// The runtime used for the function
	runtime: #Runtime

	// Directory containing the files for the cloud functions
	source: dagger.#FS | string
	docker.#Build & {
		steps: [
			gcp.#GCloud & {
				"config": config.gcpConfig
			},

			docker.#Run & {
				always: true
				mounts: {
					"source": {
						dest: "/src"
						contents: source
					}
				}
				env: {
					"NAME": name
					"RUNTIME": runtime
				}
				command: {
					name: "/bin/bash"
					args: [
						"-c",
						"gcloud", "functions",
						"deploy", "${NAME}",
						"--runtime", "${RUNTIME}",
						"--source", "/src",
						"--trigger-http",
						"--allow-unauthenticated",
					]
				}
			}
		]
	}
}
