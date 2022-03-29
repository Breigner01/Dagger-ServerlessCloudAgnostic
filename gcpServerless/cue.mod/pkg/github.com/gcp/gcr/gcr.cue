// Google Container Registry
package gcr

import (
	"universe.dagger.io/docker"
	"github.com/gcp"
)

// Credentials retriever for GCR
#Credentials: {
	// GCP Config
	config: gcp.#Config

	// GCR registry username
	username: "oauth2accesstoken"

	// GCR registry secret
	docker.#Build & {
		steps: [
			gcp.#GCloud & {
				"config": config
			},

			docker.#Run & {
				command: {
					name: "/bin/bash"
					args: [
						"--noprofile",
						"--norc",
						"-eo",
						"pipefail",
						"-c",
						"printf", "$(gcloud auth print-access-token)", ">", "/token.txt"
					]
				}
			},
		]
	}
}