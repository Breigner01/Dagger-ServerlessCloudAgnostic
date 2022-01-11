package azureserverless

import (
    "github.com/barbo69/azureserverless/ressourcegroup"
    "github.com/barbo69/azureserverless/storage"
    "github.com/barbo69/azureserverless/function"
)

#deploy: {
    rg: ressourcegroup.#ResourceGroup
    
    st: storage.#StorageAccount & {
        rgName: rg.rgName
        stLocation: rg.rgLocation
    }

    func: function.#function & {
        funcLocation: rg.rgLocation
        rgName: rg.rgName
        stName: st.stName
    }

}