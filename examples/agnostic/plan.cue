package agnosticTests

import (
	"dagger.io/dagger"
	"github.com/agnostic/config"
	"github.com/agnostic/function"
	"github.com/gcp"
	"github.com/gcp/gcr"
)

dagger.#Plan & {
	client: {
		env: GCP_PROJECT: string
		filesystem: {
			"./secrets/serviceKey.json": read: contents: dagger.#Secret
			"./src": read: contents: dagger.#FS
		}
	}

	actions: {
		Gcp: function.#Function & {
			configFunction: config.#Config & {
				gcpConfig: gcr.#Credentials & {
					config: gcp.#Config & {
						serviceKey: client.filesystem."./secrets/serviceKey.json".read.contents
						project: client.env.GCP_PROJECT
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