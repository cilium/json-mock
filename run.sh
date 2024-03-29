#!/bin/bash

SERVER_ARGS="$@"

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

if [ ! -z "$MIDDLEWARE" ]; then
        SERVER_ARGS="$SERVER_ARGS --middlewares $MIDDLEWARE"
else
        SERVER_ARGS="$SERVER_ARGS --middlewares /middleware.js"
fi

exec /usr/bin/tini -- /usr/local/bin/json-server --host "" $SERVER_ARGS
