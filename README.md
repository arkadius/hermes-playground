# Playground for [Hermes](https://github.com/allegro/hermes)

This repository is a set of scripts and configurations that make it easy to develop, test and experiment with [Hermes](https://github.com/allegro/hermes) project.
The project makes it easy to test full publish-subscribe flow in docker containers. Additionally it provides:
* SSL configuration to deliver events over HTTPS
* test subscriber that receive and log events to stdout
* scripts to create group, topics (AVRO and JSON) and subscriptions (HTTP and HTTPS)
* automate building Hermes and docker images

## Requirements
* Docker
* Java (1.8+)
* bash

## Usage
### Build Hermes and run in docker containers:
Build all Hermes modules (consumers, frontend and management), test subscriber and their docker images:
```bash
./build-hermes.sh --path=/your/local/hermes
```

Run hermes, kafka, zookeeper, schema-registry, graphite and test subscriber in docker containers:
```bash
docker-compose up
```

Now you can create groups, topics and subscriptions and then publish events:
```bash
./setup-group-topics-subscriptions.sh
./publish-events.sh --topic=pl.allegro.test.JsonHttp --limit=10
```

## Development
To avoid passing hermes path to `build-hermes.sh` export this path as `HERMES_PATH`:
```bash
export HERMES_PATH=<your-hermes-directory>/hermes
```

To rebuild a single Hermes module and its docker image pass the name of this module to the build script:
```bash
./build-hermes.sh management
```

Test subscriber exposes endpoints /200, /301, /400 and /500 that return HTTP statuses 200, 301, 400 and 500.
So if you want to test subscription that returns fixed HTTP status set the appropriate endpoint in this subscription.
```
http://subscriber:8080/200
http://subscriber:8080/301
http://subscriber:8080/400
http://subscriber:8080/500
```
