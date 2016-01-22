#!/bin/sh

envtpl /usr/src/app/thumbor.conf.tpl  --allow-missing --keep-template

if [ -n "$LOG_LEVEL" ]; then
    LOG_PARAMETER="-l $LOG_LEVEL"
fi

if [ "$1" = 'thumbor' ]; then
    exec thumbor --port=80 --conf=/usr/src/app/thumbor.conf $LOG_PARAMETER
fi

exec "$@"
