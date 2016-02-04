#!/bin/bash
set -e

# If not set we use thumbor host default value
if [ -z ${THUMBOR_HOST+x} ]; then
    THUMBOR_HOST=thumbor
fi

# If not set we use thumbor port default value
if [ -z ${THUMBOR_PORT+x} ]; then
    THUMBOR_PORT=80
fi

# If not set we use 80 for nginx port
if [ -z ${NGINX_PORT+x} ]; then
    NGINX_PORT=80
fi

sed -i -e "s/server thumbor_host:thumbor_port/server $THUMBOR_HOST:$THUMBOR_PORT/g"  /etc/nginx/nginx.conf
sed -i -e "s/listen 80 default/listen $NGINX_PORT default/g"  /etc/nginx/nginx.conf

if [ "$1" = 'nginx-daemon' ]; then
    exec nginx -g "daemon off;";
fi

exec "$@"
