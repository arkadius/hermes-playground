#!/bin/bash

echo "Create subscription pl.allegro.test.Foo\$http-subscriber"
curl -XPOST 'http://localhost:8090/topics/pl.allegro.test.Foo/subscriptions' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -d '@./subscription-http.json'

