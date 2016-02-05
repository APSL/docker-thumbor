#!/bin/sh

envtpl /usr/src/app/thumbor.conf.tpl  --allow-missing --keep-template

# If log level is defined we configure it, else use default log_level = info
if [ -n "$LOG_LEVEL" ]; then
    LOG_PARAMETER="-l $LOG_LEVEL"
fi

# Check if thumbor port is defined -> (default port 80)
if [ -z ${THUMBOR_PORT+x} ]; then
    THUMBOR_PORT=8000
fi

if [ "$1" = 'thumbor' ]; then
    exec thumbor --port=$THUMBOR_PORT --conf=/usr/src/app/thumbor.conf $LOG_PARAMETER
fi

exec "$@"
