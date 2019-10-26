# hermes-dev-environment

hermes-dev-environment is an easy-to-use dev configuration of the Hermes project (https://github.com/allegro/hermes) based on docker containers.

## Usage
```bash
export HERMES_PATH=<your-hermes-directory>/hermes

# build hermes and docker images with hermes modules
./build-images.sh

# run containers with hermes (consumers, frontend, management), kafka, zookeeper, graphite and subscriber
docker-compose up

# setup topic and subscription
./setup-data.sh

# publish events
./publish-events.sh --topic=pl.allegro.test.Foo --limit=10
```
