#!/bin/bash

mkdir -p /V/{conf,logs}
chown $(id -u):$(id -u) -R /V/{conf,logs}
chmod 777 -R /V/{conf,logs}

touch /V/logs/error.log /V/conf/nginx.conf
tail -F /V/logs/error.log &
tail -F /V/logs/access.log &

exec nginx -g 'daemon off;' -c /etc/nginx/nginx-user.conf
