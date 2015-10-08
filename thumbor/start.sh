#!/bin/sh

envtpl /usr/src/app/thumbor.conf.tpl  --allow-missing --keep-template
exec thumbor --port=80 --conf=/usr/src/app/thumbor.conf
