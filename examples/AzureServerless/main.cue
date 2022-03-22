package AzureServerlessTest

import (
	"dagger.io/dagger"
	"github.com/AzureServerless/Azure/Login"
)

dagger.#Plan & {

	client: env: AZ_SUB_ID_TOKEN: dagger.#Secret

	actions: login: Login.#Image & {
		config: Login.#Config & {
			subscriptionId: client.env.AZ_SUB_ID_TOKEN
		}
	}
}	