package function

import (
	"alpha.dagger.io/dagger"
	"alpha.dagger.io/gcp"
	"alpha.dagger.io/dagger/op"
	"github.com/gcpServerless/configServerless"
)

#Function: {
	config: configServerless.#Config

	name: string

	runtime: string

	// Directory containing the files for the cloud functions
	source: dagger.#Input & {dagger.#Artifact}

	#up: [
		op.#Load & {
			from: gcp.#GCloud & {
				"config": config.configGcp
			}
		},

		op.#Exec & {
			always: true
			args: ["/bin/bash", "-c", #"""
				gcloud auth list
			"""#]
		},

		op.#Exec & {
			always: true
			mount: "/src": from: source
			env: {
				NAME:    name
				RUNTIME: runtime
			}
			args: ["/bin/bash", "-c", #"""
				gcloud functions deploy ${NAME} --runtime ${RUNTIME} --source /src --trigger-http --allow-unauthenticated
			"""#]
		},
	]
}
