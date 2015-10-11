#!/bin/bash
set -e

[[ -z $REDIS_HOST ]] && REDIS_HOST=redis
[[ -z $REDIS_PORT ]] && REDIS_PORT=6379
[[ -z $REDIS_DATABASE ]] && REDIS_DATABASE=0
[[ -z $LOG_LEVEL ]] && LOG_LEVEL=INFO

if [ "$1" = 'remotecv' ]; then
    exec remotecv --host $REDIS_HOST --port $REDIS_PORT --database $REDIS_DATABASE -l $LOG_LEVEL
fi

exec "$@"
