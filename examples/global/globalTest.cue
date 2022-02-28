package globalTest

import (
    "github.com/global/config"
    "github.com/AzureServerless"
)

config.#Config & {
    config: AzureServerless.#Config
    provider: "azure"
}