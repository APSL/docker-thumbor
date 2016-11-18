#!/bin/bash
set -e

# If not set we use thumbor host default value
if [ -z $THUMBOR_DEFAULT_HOST ]; then
    THUMBOR_DEFAULT_HOST=thumbor
fi

# If not set we use thumbor port default value
if [ -z $THUMBOR_DEFAULT_PORT ]; then
    THUMBOR_DEFAULT_PORT=8000
fi

# If not set we use 80 for nginx port
if [ -z $NGINX_DEFAULT_PORT ]; then
    NGINX_DEFAULT_PORT=80
fi

sed -i -e "s/server thumbor_host:thumbor_port/server $THUMBOR_DEFAULT_HOST:$THUMBOR_DEFAULT_PORT/g"  /etc/nginx/nginx.conf
sed -i -e "s/listen 80 default/listen $NGINX_DEFAULT_PORT default/g"  /etc/nginx/nginx.conf

if [ "$THUMBOR_ALLOW_CORS" != "true" ]; then
    sed -i "/.*Access-Control-Allow.*/d" /etc/nginx/nginx.conf
fi

if [ "$THUMBOR_ALLOW_CONTENT_DISPOSITION" != "true" ]; then
    sed -i "/.*Content-Disposition.*/d" /etc/nginx/nginx.conf
fi

if [ "$1" = 'nginx-daemon' ]; then
    exec nginx -g "daemon off;";
fi

exec "$@"
