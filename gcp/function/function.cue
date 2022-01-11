package function

import (
	"alpha.dagger.io/dagger"
	"alpha.dagger.io/gcp"
	"alpha.dagger.io/dagger/op"
)

#Function: {
	config: gcp.#Config

	name: string

	runtime: string

	code: string

	#up: [
		op.#Load & {
			from: gcp.#Gcloud & {
				"config": config
			}
			op.#Exec & {
				always: true
				args: [
					"/bin/bash",
					"-c",
					"gcloud functions deploy" " --runtime nodejs16 --trigger-http --allow-unauthenticated",
				]
			}
		},
	]
}
