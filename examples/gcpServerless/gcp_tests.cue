package gcp_tests

import (
	"alpha.dagger.io/gcp"
	"github.com/gcpServerless/configServerless"
	"github.com/gcpServerless/function"
)

gcpConfig: gcp.#Config

config: configServerless.#Config & {
	configGcp: gcpConfig
}

HelloWorld: function.#Function & {
	"config": config

	name: "HelloWorld"

	runtime: "go116"
}
