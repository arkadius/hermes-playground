#!/bin/bash

if [ "$1" == "--help" ]
then
    echo "Usage:"
    echo "./build-hermes.sh - build all hermes modules and docker images based on the env variable HERMES_PATH"
    echo "./build-hermes.sh <module-name> - build given module and its docker image, <module-name> could be consumers, frontend or management"
    echo "./build-hermes.sh -p/--path=<local-hermes-path> - build all hermes modules and docker images based on given path"
    echo "./build-hermes.sh -p/--path=<local-hermes-path> <module-name> - build given module and its docker image based on given path"
    exit 0
fi

HERMES_DIR=$HERMES_PATH

if [ $# -gt 0 ]
then
    for i in "$@"
    do
    case $i in
        -p=*|--path=*)
        HERMES_DIR="${i#*=}"
        shift
        ;;
        *)
        HERMES_MODULE="${i#*=}"
        shift
        ;;
    esac
    done
fi

if [[ -z "${HERMES_DIR}" && -z "${HERMES_PATH}" ]]
then
    echo "Parameter -p/--path was not passed and environment variable HERMES_PATH is not set."
    exit 1
elif [ -n "${HERMES_MODULE}" ]
then
    echo "Building hermes-${HERMES_MODULE} image..."
    rm modules/${HERMES_MODULE}/hermes-${HERMES_MODULE}-*.zip
    cp ${HERMES_DIR}/hermes-${HERMES_MODULE}/build/distributions/hermes-${HERMES_MODULE}-*.zip modules/${HERMES_MODULE}/
    docker build -t hermes-${HERMES_MODULE}:latest modules/${HERMES_MODULE}/
else
    echo "Building all hermes modules..."
    ${HERMES_DIR}/gradlew clean -p ${HERMES_DIR}
    ${HERMES_DIR}/gradlew distZip -Pdistribution -p ${HERMES_DIR}

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
    rm modules/subscriber/server
    (cd modules/subscriber && ./build.sh)
    mv server modules/subscriber/
    docker build -t hermes-subscriber:latest modules/subscriber
fi

