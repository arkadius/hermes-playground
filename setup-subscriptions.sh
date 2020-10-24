#!/bin/bash

echo "Create subscription pl.allegro.test.JsonHttp\$json-http-subscriber"
curl -XPOST 'http://localhost:8090/topics/pl.allegro.test.JsonHttp/subscriptions' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -d '@./subscriptions/subscription-json-http.json'

echo "Create subscription pl.allegro.test.JsonHttps\$json-https-subscriber"
curl -XPOST 'http://localhost:8090/topics/pl.allegro.test.JsonHttps/subscriptions' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -d '@./subscriptions/subscription-json-https.json'

echo "Create subscription pl.allegro.test.AvroHttp\$avro-http-subscriber"
curl -XPOST 'http://localhost:8090/topics/pl.allegro.test.AvroHttp/subscriptions' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -d '@./subscriptions/subscription-avro-http.json'

echo "Create subscription pl.allegro.test.AvroHttps\$avro-https-subscriber"
curl -XPOST 'http://localhost:8090/topics/pl.allegro.test.AvroHttps/subscriptions' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -d '@./subscriptions/subscription-avro-https.json'
