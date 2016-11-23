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

# Using this hack to case insensitive envars
shopt -s nocasematch

case "$THUMBOR_ALLOW_CORS" in
    "true")
        echo "Configuring nginx: Enabling CORS"
        ;;
    *) 
        echo "Configuring nginx: Disabling CORS"
        sed -i "/.*THUMBOR_ALLOW_CORS.*/d" /etc/nginx/nginx.conf
        ;;
esac

case "$THUMBOR_ALLOW_CONTENT_DISPOSITION" in
    "true")
        echo "Configuring nginx: Enabling Content-Disposition"
        ;;
    *) 
        echo "Configuring nginx: Disabling Content-Disposition"
        sed -i "/.*THUMBOR_ALLOW_CONTENT_DISPOSITION.*/d" /etc/nginx/nginx.conf
        ;;
esac

case "$AUTO_WEBP" in
    "true")
        echo "Configuring nginx: Enabling WEBP "
        sed -i "/.*DEFAULT_CASE_WITHOUT_WEBP.*/d" /etc/nginx/nginx.conf
        ;;
    *) 
        echo "Configuring nginx: Disabling Enabling WEBP"
        sed -i "/.*AUTO_WEBP.*/d" /etc/nginx/nginx.conf
        ;;
esac

if [ "$1" = 'nginx-daemon' ]; then
    exec nginx -g "daemon off;";
fi

exec "$@"
