#!/bin/bash

container_exit() {
    exit 0
}

trap "container_exit" SIGTERM

mkdir -p /V/{conf,db,logs}
chown $(id -u):$(id -u) -R /V/{conf,db,logs}
chmod 777 -R /V/{conf,db,logs}

nginx -g 'daemon off;'

tail -F /var/log/nginx/error.log &
wait $!
container_exit