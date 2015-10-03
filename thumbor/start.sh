#!/bin/sh

envtpl /usr/src/app/thumbor.conf.tpl  --allow-missing --keep-template
thumbor --port=80 --conf=/usr/src/app/thumbor.conf

# echo "--> start.sh script running..."
# envtpl /etc/circus.ini.tpl  --allow-missing --keep-template
#
# echo "---> Starting circus..."
# exec /usr/local/bin/circusd /etc/circus.ini
