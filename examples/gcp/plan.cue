package test

import (
	"dagger.io/dagger"
	"github.com/gcp"
	"github.com/gcp/gcr"
	"github.com/gcp/function"
)

dagger.#Plan & {
	client: {
		env: GCP_PROJECT: string
		filesystem: {
			"./src": read: contents: dagger.#FS
			"./secrets/serviceKey.json": read: contents: dagger.#Secret
		}
	}

	actions: {
		HelloWorld: function.#Function & {
			config: gcr.#Credentials & {
				config: gcp.#Config & {
					serviceKey: client.filesystem."./secrets/serviceKey.json".read.contents
					project: client.env.GCP_PROJECT
					region: "europe-west3"
					zone: "europe-west3-b"
				}
			}
			name:     "HelloWorld"
			runtime:  "go116"
			source: client.filesystem."./src".read.contents
		}
	}
}
