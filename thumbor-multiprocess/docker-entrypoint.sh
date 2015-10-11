#!/bin/sh

run-parts -v  --report /etc/setup.d

envtpl /usr/src/app/thumbor.conf.tpl  --allow-missing --keep-template
envtpl /etc/circus.ini.tpl  --allow-missing --keep-template
envtpl /etc/circus.d/thumbor.ini.tpl  --allow-missing --keep-template

if [ "$1" = 'circus' ]; then
    echo "---> Starting circus..."
    exec /usr/local/bin/circusd /etc/circus.ini
fi

exec "$@"
