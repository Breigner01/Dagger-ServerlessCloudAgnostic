package config

import (
	"github.com/gcpServerless/configServerless"
	"github.com/azure/login"
)

#Config: {
	config: configServerless.#Config | login.#CLI
}
