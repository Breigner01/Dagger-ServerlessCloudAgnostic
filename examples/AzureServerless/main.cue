package AzureServerlessTest

import (
	"dagger.io/dagger"
	"github.com/AzureServerless/Azure/Login"
	"github.com/AzureServerless"
)

dagger.#Plan & {

	client: {
		env: AZ_SUB_ID_TOKEN: dagger.#Secret
	
		filesystem: "./deploy_function": read: contents: dagger.#FS
	}

	actions: {
		"deployFunction": AzureServerless.#Deploy & {
		
			source: client.filesystem."./deploy_function".read.contents

			config: AzureServerless.#Config & {
				login: Login.#Config & {
					subscriptionId: client.env.AZ_SUB_ID_TOKEN
					version: "3.0"
				}
				location: "northeurope"
				resourceGroup: name: "rg12121"
				storage: name: "st21212"
				functionApp: {
					name: "fa121211"
					args: ["--runtime", "node", "--runtime-version", "14"]
				}
				publishFunction: args: ["--javascript"]

			}
		}
	}
}