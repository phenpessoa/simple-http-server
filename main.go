package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("GET /", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintln(w, "hello, world")
	})
	if err := http.ListenAndServe(":8080", nil); err != nil {
		panic(err)
	}
}
