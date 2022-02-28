package AzureFuncCoreTool

import (
	"strings"	
    "alpha.dagger.io/dagger"
	"alpha.dagger.io/os"
    "github.com/AzureServerless/Azure/Login"
)

#AzureFuncCoreTool: {

    // Azure Config
	config: Login.#Config

	// Azure Config
	version: string

    // Function name
	name: string & dagger.#Input 

    // Source directory
    source: dagger.#Artifact @dagger(Input)

	// Additional arguments
    args: [...string] | *[""]

	ctr: os.#Container & {
		image: Login.#CLI & {
			"config": config
			"version": version
		}

		mount: "/src": from: source

		dir: "/src"

		always: true

		command: #"""
			func azure functionapp publish "$AZURE_DEFAULTS_FUNCTION"\
			$ARGS
			"""#

		env: {
			AZURE_DEFAULTS_FUNCTION: name
			ARGS: strings.Join(args, " ")
		}
	}	
}