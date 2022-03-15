#!/bin/bash

set -e

echo "Build test subscriber..."
docker build -t hermes-test-subscriber-build:latest -f Dockerfile.gobuild .
docker container create --name gobuild hermes-test-subscriber-build:latest
docker container cp gobuild:/opt/server ./server
docker container rm -f gobuild