package Function

import (
	"github.com/barbo69/AzureServerless/Login"
	"alpha.dagger.io/os"
	"alpha.dagger.io/dagger"
)

#function: {
    // Azure Config
	config: Login.#Config

    // Function name
    name: string & dagger.#Input

    // Function location
    location: string & dagger.#Input 

    // ResourceGroup name
    ressourceGroup: name: string & dagger.#Input

    // Storage name
    storage: name: string & dagger.#Input

    // Function Id
	id: string & dagger.#Output

    // Source file
    source: dagger.#Artifact @dagger(input)

    ctr: os.#Container & {
        image: Login.#CLI & {
			"config": config
		}

        always: true

        dir: "src"

        mount: "/src": from: source

        command: """
            az functionapp create --resource-group "$AZURE_DEFAULTS_GROUP" --consumption-plan-location "$AZURE_DEFAULTS_LOCATION" --runtime node --runtime-version 12 --functions-version 3 --name "$AZURE_DEFAULTS_FUNCTION" --storage-account "$AZURE_DEFAULTS_STORAGE"
        """
        
        env: {
            AZURE_DEFAULTS_GROUP:    ressourceGroup.name
            AZURE_DEFAULTS_STORAGE:  storage.name
            AZURE_DEFAULTS_LOCATION: location
            AZURE_DEFAULTS_FUNCTION: name
        }
    }

	id: ({
		os.#File & {
			from: ctr
			path: "/functionId"
		}
	}).contents
}