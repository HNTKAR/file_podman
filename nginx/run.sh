#!/bin/bash

mkdir -p /V/{conf,logs,sites}
cp -rf /usr/local/share/sites/* /V/sites/
chown -R $(id -u nginx):$(id -u nginx) /V/{conf,logs,sites} 
chmod -R 777 /V/{conf,logs,sites}

touch /V/logs/access.log /V/logs/error.log /V/conf/nginx.conf
tail -F /V/logs/error.log &
tail -F /V/logs/access.log &

exec nginx -c /etc/nginx/nginx-user.conf -g 'daemon off;'
