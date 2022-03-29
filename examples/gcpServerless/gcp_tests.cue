package test

import (
	"dagger.io/dagger"
	"github.com/gcp"
	"github.com/gcpServerless/configServerless"
	"github.com/gcpServerless/function"
)

dagger.#Plan & {
	client: {
		filesystem: {
			"src": read: contents: dagger.#FS
			"secrets/dagger-dev-339319-b3059441ca31.json": read: contents: dagger.#FS
		}
	}

	actions: {
		HelloWorld: function.#Function & {
			config:	configServerless.#Config & {
				gcpConfig: gcp.#Config & {
					serviceKey: client.filesystem."secrets/dagger-dev-339319-b3059441ca31.json".read.contents
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
