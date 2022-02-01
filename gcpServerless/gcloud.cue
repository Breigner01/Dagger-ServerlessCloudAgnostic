package gcpServerless

import (
	"alpha.dagger.io/dagger"
	"alpha.dagger.io/gcp"
)

#Gcloud: gcp.Gcloud & {
	version: string | *"368.0.0"
}
