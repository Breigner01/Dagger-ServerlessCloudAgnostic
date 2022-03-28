package gcp

import (
    "universe.dagger.io/docker"
)

#GCloud: {
    config: #Config
    version: string | *"377.0.0"
    package: [string]: string | bool

    _gcloud: docker.#Build & {
        steps: [
            docker.#Pull & {
                source: "gcr.io/google.com/cloudsdktool/google-cloud-cli:\#(version)-alpine"
            },

            docker.#Run & {
                mount: "/service_key": secret: config.serviceKey
                command: {
                    name: "gcloud"
                    args: ["-q", "auth", "activate-service-account", "--key-file=/service_key"]
                }
            },

            docker.#Run & {
                command: {
                    name: "gcloud"
                    args: ["-q", "config", "set", "project", config.project]
                }
            },

            if config.region != null {
                docker.#Run & {
                    command: {
                        name: "gcloud"
                        args: ["-q", "config", "set", "compute/region", config.region]
                    }
                }
            },

            if config.zone != null {
                docker.#Run & {
                    command: {
                        name: "gcloud"
                        args: ["-q", "config", "set", "compute/zone", config.zone]
                    }
                }
            },
        ]
    }

    output: _gcloud.output
}