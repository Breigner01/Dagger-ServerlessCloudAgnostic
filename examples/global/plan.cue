package globalTests

import (
	"dagger.io/dagger"
	"github.com/global/config"
	"github.com/global/function"
	"github.com/gcp"
	"github.com/gcp/gcr"
)

dagger.#Plan & {
	client: {
		filesystem: {
			"./src": read: contents: dagger.#FS
			"./secrets/dagger-dev-339319-b3059441ca31.json": read: contents: dagger.#Secret
		}
	}

	actions: {
		Gcp: function.#Function & {
			configFunction: config.#Config & {
				gcpConfig: gcr.#Credentials & {
					config: gcp.#Config & {
						serviceKey: client.filesystem."./secrets/dagger-dev-339319-b3059441ca31.json".read.contents
						project: "dagger-dev-339319"
						region: "europe-west3"
						zone: "europe-west3-b"
					}
				}
				provider: "gcp"
			}
			runtime: "go"
			runtimeVersion: "116"
			name: "HelloWorld"
			source: client.filesystem."./src".read.contents
		}
	}
}