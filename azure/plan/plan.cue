package plan

import (
  "github.com/barbo69/AzureServerless"
)

config: AzureServerless.#config

run: AzureServerless.#deploy & {
    "config": config 
}
