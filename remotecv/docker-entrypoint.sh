#!/bin/bash

# To disable warning libdc1394 error: Failed to initialize libdc1394
ln -s /dev/null /dev/raw1394

set -e

[[ -z $REDIS_HOST ]] && REDIS_HOST=redis
[[ -z $REDIS_PORT ]] && REDIS_PORT=6379
[[ -z $REDIS_DATABASE ]] && REDIS_DATABASE=0
[[ -z $LOG_LEVEL ]] && LOG_LEVEL=INFO
[[ -z $REMOTECV_LOADER ]] && REMOTECV_LOADER=remotecv.http_loader
[[ -z $STORE ]] && STORE=remotecv.result_store.redis_store
if [ -n "$TIMEOUT" ]; then
    TIMEOUT_PARAMETER="-t $TIMEOUT"
fi
if [ -n "$SENTRY_URL" ]; then
    SENTRY_URL_PARAMETER="--sentry_url $SENTRY_URL"
fi

if [ "$1" = 'remotecv' ]; then
    echo "#####################"
    echo "Starting remotecv"
    echo "#####################"
    echo "Redis -  Host: $REDIS_HOST Port: $REDIS_PORT Database: $REDIS_DATABASE"
    echo "Log level: $LOG_LEVEL"
    echo "Loader: $REMOTECV_LOADER"
    echo "Store: $STORE"
    echo "Timeout: $TIMEOUT"
    echo "Sentry URL: $SENTRY_URL"
    echo "#####################"
    exec remotecv --host $REDIS_HOST --port $REDIS_PORT --database $REDIS_DATABASE -l $LOG_LEVEL -o $REMOTECV_LOADER -s $STORE $TIMEOUT_PARAMETER $SENTRY_URL_PARAMETER
fi

exec "$@"
