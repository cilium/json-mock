#!/bin/bash

SERVER_ARGS="--host '' $@"

if [ ! -z "$PORT" ]; then
        SERVER_ARGS="$SERVER_ARGS --port $PORT"
else
        SERVER_ARGS="$SERVER_ARGS --port 80"
fi

if [ ! -z "$FILE" ]; then
        SERVER_ARGS="$SERVER_ARGS --watch $FILE"
else
        SERVER_ARGS="$SERVER_ARGS --watch /default.json"
fi

sh -c "json-server $SERVER_ARGS"
