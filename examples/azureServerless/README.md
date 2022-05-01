# AzureServeless Example

You can have a look at the [plan.cue](./plan.cue) file which contains the example to deploy a serverless function with Azure.

If you want to deploy this serveless function, you need to set an AZ_SUB_ID_TOKEN environnment variable with your Azure Subscription id. You can use the .envrc file with direnv or manually set it.
 
Once you've setup everything, you can simply run:

```shell
dagger do deployFunction
```
It will deploy a cloud function sending back HelloWorld when you make a request on the url.