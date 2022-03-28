package test

import (
	"dagger.io/dagger"
	"github.com/gcp"
	"github.com/gcpServerless/configServerless"
	"github.com/gcpServerless/function"
)

dagger.#Plan & {
	client: {
		env: GCP_SERVICE_KEY: dagger.#Secret

		filesystem: "src": read: contents: dagger.#FS
	}

	actions: {
		HelloWorld: function.#Function & {
			config:	configServerless.#Config & {
				gcpConfig: gcp.#Config & {
					serviceKey: client.env.GCP_SERVICE_KEY
					project: "dagger-dev-339319"
					region: "europe-west3"
					zone: "europe-west3-b"
				}
			}
			name:     "HelloWorld"
			runtime:  "go116"
			source: client.filesystem."src".read.contents
		}
	}
}
