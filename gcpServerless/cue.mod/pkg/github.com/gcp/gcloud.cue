package gcp

import (
    "universe.dagger.io/alpine"
    "universe.dagger.io/docker"
)

#GCloud: {
    config: #Config
    version: string | *"377.0.0"
    package: [string]: string | bool

    _gcloud: docker.#Build & {
        steps: [
            alpine.#Build & {
                packages: [
                    "bash",
                    "python3",
                    "jq",
                    "curl",
                ]
            },

            docker.#Run & {
                command: {
                    name: "sh"
                    args: [
                        "-c",
                        "curl", "-sFL", "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-\(version)-linux-x86_64.tar.gz",
                        "|", "tar", "-C", "/usr/local", "-zx", "&&",
                        "ln", "-s", "/usr/local/google-cloud-sdk/bin/gcloud", "/usr/local/bin", "&&",
                        "ln", "-s", "/usr/local/google-cloud-sdk/bin/gsutil", "/usr/local/bin",
                    ]
                }
            },

            docker.#Run & {
                mounts: {
                    source: {
                        dest: "/service_key"
                        contents: config.serviceKey
                    }
                }
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

            if (config.region & null) != _|_ {
                docker.#Run & {
                    command: {
                        name: "gcloud"
                        args: ["-q", "config", "set", "compute/region", config.region]
                    }
                }
            },

            if (config.zone & null) != _|_ {
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