package agnosticTests

import (
	"dagger.io/dagger"
	"github.com/agnostic/config"
	"github.com/agnostic/function"
	"github.com/gcp"
	"github.com/gcp/gcr"
	"github.com/azureServerless"
	"github.com/azureServerless/azure/login"
)

dagger.#Plan & {
	client: {
		env: {
			GCP_PROJECT:     string
			AZ_SUB_ID_TOKEN: dagger.#Secret
		}
		filesystem: {
			"./secrets/serviceKey.json": read: contents: dagger.#Secret
			"./src": read: contents:                     dagger.#FS
			"./deploy_function": read: contents:         dagger.#FS
		}
	}

	actions: {
		Gcp: function.#Function & {
			configFunction: config.#Config & {
				gcpConfig: gcr.#Credentials & {
					config: gcp.#Config & {
						serviceKey: client.filesystem."./secrets/serviceKey.json".read.contents
						project:    client.env.GCP_PROJECT
						region:     "europe-west3"
						zone:       "europe-west3-b"
					}
				}
				provider: "gcp"
			}
			runtime:        "go"
			runtimeVersion: "116"
			name:           "HelloWorld"
			source:         client.filesystem."./src".read.contents
		}

		Azure: function.#Function & {
			configFunction: config.#Config & {
				azureConfig: azureServerless.#Config & {
					"login": login.#Config & {
						subscriptionId: client.env.AZ_SUB_ID_TOKEN
						version:        "3.0"
					}
					location: "northeurope"
					resourceGroup: name: "daggerrg"
					storage: name:       "daggerst1"
					functionApp: {
						name: "daggerfa1"
						args: ["--runtime", "node", "--runtime-version", "14"]
					}
					publishFunction: args: ["--javascript"]
				}
				runtime:        "node"
				runtimeVersion: "14"
				name:           "daggerfa1"
				source:         client.filesystem."./deploy_function".read.contents
			}
		}
	}
}
