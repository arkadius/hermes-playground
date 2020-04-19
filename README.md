# hermes-dev-environment

hermes-dev-environment is an easy-to-use dev configuration of the Hermes project (https://github.com/allegro/hermes) based on docker containers.

## Usage
```bash
export HERMES_PATH=<your-hermes-directory>/hermes

# build hermes and docker images with hermes modules
./setup-environments.sh

# run containers with hermes (consumers, frontend, management), kafka, zookeeper, graphite and subscriber
docker-compose up

# setup topic and subscription
./setup-subscriptions.sh

# publish events
./publish-events.sh --topic=pl.allegro.test.Foo --limit=10
```

If you need subscriber that returns 500 create a subscription with endpoint:
```
http://subscriber:8099/500
```

If you need subscriber that returns 301 create a subscription with endpoint:
```
http://subscriber:8099/301
```

The configured subscriber returns 200 for all other endpoints, e.g.
```
http://subscriber:8099/200
http://subscriber:8099/test
...
```
