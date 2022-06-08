package main

import (
	"context"
	"fmt"
	"html/template"
	"log"
	"net/http"
)

var ctx = context.Background()

func add(w http.ResponseWriter, r *http.Request) {
	client, err := GetRedisClient(ctx)
	if err != nil {
		panic(err)
	}
	defer client.Close()
	r.ParseForm()
	err = AddRow(client, r.Form["text"][0])
	if err != nil {
		http.Error(w, fmt.Sprintf("error: %s", err), http.StatusInternalServerError)
	}

	http.Redirect(w, r, "/", http.StatusFound)
}

func main() {

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		client, err := GetRedisClient(ctx)
		if err != nil {
			panic(err)
		}
		defer client.Close()

		rows, err := listRows(client)
		if err != nil {
			panic(err)
		}

		t, _ := template.ParseFiles("index.html")
		t.Execute(w, rows)
	})

	http.HandleFunc("/add", add)
	log.Fatal(http.ListenAndServe(":80", nil))
}
