#!/bin/bash

echo "Create group pl.allegro.test"
curl -XPOST 'http://localhost:8090/groups' \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json;charset=UTF-8' \
    -d '{"groupName":"pl.allegro.test"}'
