#!/bin/sh

run-parts -v  --report /etc/setup.d

envtpl /etc/circus.ini.tpl  --allow-missing --keep-template
envtpl /etc/circus.d/remotecv.ini.tpl  --allow-missing --keep-template

if [ "$1" = 'circus' ]; then
    echo "---> Starting circus..."
    exec /usr/local/bin/circusd /etc/circus.ini
fi

exec "$@"
