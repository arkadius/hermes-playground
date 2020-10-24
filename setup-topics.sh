#!/bin/bash

echo "Create topic pl.allegro.test.JsonHttp"
curl -XPOST 'http://localhost:8090/topics' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -d '@./topics/topic-json-http.json'

echo "Create topic pl.allegro.test.JsonHttps"
curl -XPOST 'http://localhost:8090/topics' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -d '@./topics/topic-json-https.json'

echo "Create topic pl.allegro.test.AvroHttp"
curl -XPOST 'http://localhost:8090/topics' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -d '@./topics/topic-avro-http.json'

echo "Create topic pl.allegro.test.AvroHttps"
curl -XPOST 'http://localhost:8090/topics' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -d '@./topics/topic-avro-https.json'