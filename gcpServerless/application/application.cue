package application

import (
	import "alpha.dagger.io/dagger"
	import "github.com/PoCInnovation/Dagger-ServerlessCloudAgnostic/gcp"
)

#Application: {
	runtime: string

	application: [gcp.#Function | *gcp.#Function & {
		"runtime": runtime
	},
	]
}
