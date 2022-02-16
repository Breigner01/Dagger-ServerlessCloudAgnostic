package plan

import (
  "github.com/barbo69/AzureServerless"
)

config: AzureServerless.#Config & {
    "function": "args": ["--runtime", "node", "--runtime-version", "14", "--functions-version", "4"]
    "version": "3.0"
}

run: AzureServerless.#Deploy & {
    "config": config 
}