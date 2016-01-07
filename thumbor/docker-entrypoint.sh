#!/bin/sh

envtpl /usr/src/app/thumbor.conf.tpl  --allow-missing --keep-template

if [ "$1" = 'thumbor' ]; then
    exec thumbor --port=28765 --conf=/usr/src/app/thumbor.conf
fi

exec "$@"
