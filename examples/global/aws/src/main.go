package main

import (
	"fmt"
	"net/http"

	chiadapter "github.com/awslabs/aws-lambda-go-api-proxy/chi"
	"github.com/go-chi/chi"
)

var chiLanbdma *chiadapter

func main() {
	r := chi.NewRouter()
	r.Get("/hello-world", func (w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Hello World!"))
	})

	chiLanbdma = chiadapter.New(r)
}