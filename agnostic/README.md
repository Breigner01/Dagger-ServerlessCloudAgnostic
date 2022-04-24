# Agnostic package

This package is meant to encapsulate multiple cloud providers and make it easier for people to switch cloud provider.

## Config

This is the only part that changes upon changing the cloud provider

You are meant to setup the `cloudConfig` field corresponding to the cloud provide you want to use and fill the `provider` with a string containing the name of the cloud provider.

For the `cloudConfig` of the cloud provider, the way of doing it depends on the cloud provider but it will always be a form of logging in. Whether it's with a service key or with account credentials.

## Function

This part isn't impacted by the cloud provider you chose to use

You just have to fill few things required for a cloud function: the source folder, the name, the runtime and its version

## Examples

You can check the examples out [right here](../examples/agnostic/README.md)