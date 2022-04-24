# Agnostic Examples

You can have a look at the [plan.cue](./plan.cue) file which contains the examples to deploy serverless cloud functions to both Azure and Gcp.

If you want to deploy one of these cloud functions, provide the following:

## Gcp

It works close to the same as the standard Gcp package to some extents.
So you need to provide a service key in `secrets/serviceKey.json` and the project name in the environment variable `GCP_PROJECT`

Then you can simly run:
```shell
dagger do Gcp
```

## Azure

// TODO

