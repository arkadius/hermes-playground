#!/bin/bash

if [ $# -eq 0 ]
then
    echo "No arguments passed. Check --help option."
    exit 1
fi

if [ $1 == "--help" ]
then
    echo "To publish 10 events on topic pl.allegro.test.Foo run command:"
    echo "bash publisher.sh --topic=pl.allegro.test.Foo --limit=10"
    echo "or"
    echo "bash publisher.sh -t=pl.allegro.test.Foo -l=10"
    exit 0
fi

topic=$1
limit=$2

for i in "$@"
do
case $i in
    -t=*|--topic=*)
    TOPIC="${i#*=}"
    shift
    ;;
    -l=*|--limit=*)
    LIMIT="${i#*=}"
    shift
    ;;
    *)
        # unknown option
    ;;
esac
done

if [ -z "$TOPIC" ]
then
    echo "Topic (-t/--topic) is required argument."
    exit 1
fi

if [ -z "$LIMIT" ]
then
    echo "Limit (-l/--limit) is required argument."
    exit 1
fi

if ! [[ "$LIMIT" =~ ^[0-9]+$ ]]
then
    echo "Given limit is not a number: $LIMIT"
    exit 1
fi

for (( i=1; i<=$LIMIT; i++ ))
do
	sleep 0.2;
    echo "------ Sending $i. message... --------"
    content="{ \"id\": \"$i\", \"name\": \"test-$i\" }"
	curl --verbose -XPOST localhost:8080/topics/$TOPIC -H "Content-Type:application/json" -d "$content"
done

