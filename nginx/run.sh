#!/bin/bash

mkdir -p /V/{conf,logs,cert,sites}
cp -rf /usr/local/share/sites/* /V/sites/
chown -R $(id -u nginx):$(id -u nginx) /V/{conf,logs,sites,cert} 
chmod -R 777 /V/{conf,logs,sites,cert}

if [ -f /V/cert/status ]; then
        echo "certificates found."
else
        echo "certificates not found. Copy default certs."
        cp $CERT_DIR/* /V/cert/
        echo "$(date) certificates copied from $CERT_DIR to /V/cert" > /V/cert/status
fi

touch /V/logs/access.log /V/logs/error.log /V/conf/nginx.conf
tail -F /V/logs/error.log &
tail -F /V/logs/access.log &

exec nginx -c /etc/nginx/nginx-user.conf -g 'daemon off;'
