package test

import (
	"alpha.dagger.io/gcp"
	"github.com/gcpServerless/configServerless"
	"github.com/gcpServerless/function"
)

gcpConfig: gcp.#Config

config: configServerless.#Config & {
	"gcpConfig": gcpConfig
}

HelloWorld: function.#Function & {
	"config": config
	name:     "HelloWorld"
	runtime:  "go116"
}
