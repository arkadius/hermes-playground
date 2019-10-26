#!/bin/bash

echo "Create group pl.allegro.test"
curl -XPOST 'http://localhost:8090/groups' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -d '{"groupName":"pl.allegro.test"}'

echo "Create topic pl.allegro.test.Foo"
curl -XPOST 'http://localhost:8090/topics' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -d '@./topic.json'

echo "Create subscription pl.allegro.test.Foo\$sub1"
curl -XPOST 'http://localhost:8090/topics/pl.allegro.test.Foo/subscriptions' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -d '@./subscription.json'

