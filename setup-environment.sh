#!/bin/bash

if [ -z "${HERMES_PATH}" ]
then
    echo "Environment variable HERMES_PATH is not set."
    exit 1
fi

${HERMES_PATH}/gradlew clean -p ${HERMES_PATH}
${HERMES_PATH}/gradlew distZip -Pdistribution -p ${HERMES_PATH}

echo "Generating self-signed ssl certificate..."
docker build -t hermes-ssl-certgen:latest -f Dockerfile.certgen .
docker container create --name certgen hermes-ssl-certgen
docker container cp certgen:/etc/ssl/private/nginx-selfsigned.key ./nginx-selfsigned.key
docker container cp certgen:/etc/ssl/certs/nginx-selfsigned.crt ./nginx-selfsigned.crt
docker container rm -f certgen

cp nginx-selfsigned.crt modules/consumers
cp nginx-selfsigned.crt modules/subscriber
cp nginx-selfsigned.key modules/subscriber

echo "Building hermes-consumers image..."
rm modules/consumers/hermes-consumers-*.zip
cp ${HERMES_PATH}/hermes-consumers/build/distributions/hermes-consumers-*.zip modules/consumers/
docker build -t hermes-consumers:latest modules/consumers/

echo "Building hermes-frontend image..."
rm modules/frontend/hermes-frontend-*.zip
cp ${HERMES_PATH}/hermes-frontend/build/distributions/hermes-frontend-*.zip modules/frontend/
docker build -t hermes-frontend:latest modules/frontend/

echo "Building hermes-management image..."
rm modules/management/hermes-management-*.zip
cp ${HERMES_PATH}/hermes-management/build/distributions/hermes-management-*.zip modules/management/
docker build -t hermes-management:latest modules/management/

echo "Building hermes-subscriber..."
modules/subscriber/gradlew clean build -p modules/subscriber/
docker build -t hermes-subscriber:latest modules/subscriber

