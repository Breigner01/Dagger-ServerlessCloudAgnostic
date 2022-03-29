package azureServerlessTest

import (
	"dagger.io/dagger"
	"github.com/azureServerless/azure/login"
	"github.com/azureServerless"
)

dagger.#Plan & {

	client: {
		env: AZ_SUB_ID_TOKEN: dagger.#Secret
	
		filesystem: "./deploy_function": read: contents: dagger.#FS
	}

	actions: {
		"deployFunction": azureServerless.#Deploy & {
		
			source: client.filesystem."./deploy_function".read.contents

			config: azureServerless.#Config & {
				"login": login.#Config & {
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