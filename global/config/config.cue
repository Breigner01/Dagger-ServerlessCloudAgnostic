package config

import (
	"github.com/gcpServerless/configServerless"
	"github.com/AzureServerless"
	"alpha.dagger.io/aws"
)

#Config: {
	// The config coming from one of the serverless package
	gcpConfig: configServerless.#Config | *null

	azureConfig: AzureServerless.#Config | *null

	awsConfig: aws.#Config | *null

	provider: "gcp" | "azure" | "aws"
}
