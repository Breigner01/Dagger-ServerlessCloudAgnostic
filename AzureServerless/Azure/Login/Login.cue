// Azure base package
package Login

import (
	"dagger.io/dagger"
	"universe.dagger.io/docker"
)

// Default Azure CLI version
#DefaultVersion: "3.0"

#Config: {
	subscriptionId: dagger.#Secret
}

#Image: {

	version: *#DefaultVersion | string

	config: #Config
		
	docker.#Build & {
		steps: [
			docker.#Pull & {
				source: "barbo69/dagger-azure-cli:\(version)"
			},	
			docker.#Run & {
				command: {
					name: "az"
					args: ["login"]
				}
			},
			
			docker.#Run & {
				env: AZ_SUB_ID_TOKEN: config.subscriptionId
				command: {
					name: "sh"
					flags: "-c": "az account set -s $AZ_SUB_ID_TOKEN"
				}
			}
		]
	}
}
