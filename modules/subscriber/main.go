package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)

func main() {
		fmt.Println("Server is running...")
		http.HandleFunc("/200", successHandler)
		http.HandleFunc("/301", redirectHandler)
		http.HandleFunc("/400", clientErrorHandler)
		http.HandleFunc("/500", serverErrorHandler)
		if err := http.ListenAndServe(":8080", nil); err != nil {
			fmt.Printf("Cannot start server: %s\n", err.Error())
			os.Exit(1)
		}
		os.Exit(0)
}

func successHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == "POST" {
		reqBody, err := ioutil.ReadAll(r.Body)
		if err != nil {
			fmt.Println(err.Error())
		}
		fmt.Printf( "Endpoint /200 received event: %s\n", reqBody)
		w.WriteHeader(200)
	} else {
		unsupportedRequest(w, r)
	}
}

func redirectHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == "POST" {
		reqBody, err := ioutil.ReadAll(r.Body)
		if err != nil {
			fmt.Println(err.Error())
		}
		fmt.Printf( "Endpoint /301 received event: %s\n", reqBody)
		w.Header().Set("Location", "/200")
		w.WriteHeader(301)
	} else {
		unsupportedRequest(w, r)
	}
}

func clientErrorHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == "POST" {
		reqBody, err := ioutil.ReadAll(r.Body)
		if err != nil {
			fmt.Println(err.Error())
		}
		fmt.Printf( "Endpoint /400 received event: %s\n", reqBody)
		w.WriteHeader(400)
	} else {
		unsupportedRequest(w, r)
	}
}

func serverErrorHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == "POST" {
		reqBody, err := ioutil.ReadAll(r.Body)
		if err != nil {
			fmt.Println(err.Error())
		}
		fmt.Printf( "Endpoint /500 received event: %s\n", reqBody)
		w.WriteHeader(500)
	} else {
		unsupportedRequest(w, r)
	}
}

func unsupportedRequest(w http.ResponseWriter, r *http.Request) {
	fmt.Printf( "Received unsupported request %s\n", r.Method)
	w.WriteHeader(405)
}
