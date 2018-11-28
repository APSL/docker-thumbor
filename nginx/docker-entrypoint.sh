#!/bin/bash
set -e

STORAGE_ROOT_PATH=$(echo $RESULT_STORAGE_FILE_STORAGE_ROOT_PATH | sed 's_/_\\/_g')
sed -i -e "s/@UPSTREAM_THUMBOR_HOST/$THUMBOR_HOST/g"  /etc/nginx/nginx.conf
sed -i -e "s/@UPSTREAM_THUMBOR_PORT/$THUMBOR_PORT/g"  /etc/nginx/nginx.conf
sed -i -e "s/@DEFAULT_SERVER_PORT/$NGINX_PORT/g"  /etc/nginx/nginx.conf
sed -i -e "s/@ROOT_STORAGE_PATH;/$STORAGE_ROOT_PATH\/$PATH_FORMAT_VERSION;/g"  /etc/nginx/nginx.conf

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
