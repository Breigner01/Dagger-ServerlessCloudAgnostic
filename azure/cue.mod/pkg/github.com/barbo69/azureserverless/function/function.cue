package function

import (
	"github.com/barbo69/azureserverless/login"
	"alpha.dagger.io/os"
	"alpha.dagger.io/dagger"
)

#function: {
    // Function name
    funcName: string & dagger.#Input

    // Function location
    funcLocation: string & dagger.#Input 

    // ResourceGroup name
    rgName: string & dagger.#Input

    // Storage name
    stName: string & dagger.#Input

    // Function Id
	id: string & dagger.#Output

    // Source file
    source: dagger.#Artifact @dagger(input)

    ctr: os.#Container & {
        image: login.#CLI

        always: true

        dir: "src"

        mount: "/src": from: source

        command: """
            az functionapp create --resource-group "$AZURE_DEFAULTS_GROUP" --consumption-plan-location "$AZURE_DEFAULTS_LOCATION" --runtime node --runtime-version 12 --functions-version 3 --name "$AZURE_DEFAULTS_FUNCTION" --storage-account "$AZURE_DEFAULTS_STORAGE"
        """
        
        env: {
            AZURE_DEFAULTS_GROUP:    rgName
            AZURE_DEFAULTS_STORAGE:  stName
            AZURE_DEFAULTS_LOCATION: funcLocation
            AZURE_DEFAULTS_FUNCTION: funcName
        }
    }

	id: ({
		os.#File & {
			from: ctr
			path: "/functionId"
		}
	}).contents
}