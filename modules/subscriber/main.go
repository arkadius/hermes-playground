package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"sync"
)

type server struct {
	mux     *sync.Mutex
	counter int32
}

func main() {
	s := server{&sync.Mutex{}, 0}
	fmt.Println("HTTP server is starting...")
	http.HandleFunc("/200", s.postHandler(200, nil))
	http.HandleFunc("/301", s.postHandler(301, redirect))
	http.HandleFunc("/400", s.postHandler(400, nil))
	http.HandleFunc("/500", s.postHandler(500, nil))
	if err := http.ListenAndServe(":8080", nil); err != nil {
		fmt.Printf("Cannot start server: %s\n", err.Error())
		os.Exit(1)
	}
	os.Exit(0)
}

func (s *server) postHandler(status int, callback func(http.ResponseWriter)) func(w http.ResponseWriter, r *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		if r.Method == "POST" {
			counter := s.countAndGet()
			reqBody, err := ioutil.ReadAll(r.Body)
			if err != nil {
				fmt.Println(err.Error())
			}
			fmt.Printf("[%d] Endpoint /%d received request %s\n", counter, status, reqBody)
			if callback != nil {
				callback(w)
			}
			w.WriteHeader(status)
		} else {
			unsupportedRequest(w, r)
		}
	}
}

func (s *server) countAndGet() int32 {
	s.mux.Lock()
	defer s.mux.Unlock()
	s.counter++
	return s.counter
}

func unsupportedRequest(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("Received unsupported request %s\n", r.Method)
	w.WriteHeader(405)
}

func redirect(w http.ResponseWriter) {
	w.Header().Set("Location", "/200")
}
