#!/bin/bash

container_exit() {
    exit 0
}

trap "container_exit" SIGTERM

mkdir -p /usr/V/$CONTAINER_NAME/{conf,db,logs,share}
chown $(id -u):$(id -u) -R /usr/V/$CONTAINER_NAME
chmod 777 /usr/V/$CONTAINER_NAME

adduser -D sample
echo -e "password\npassword"|pdbedit --create --password-from-stdin  --user sample --configfile /etc/samba/smb-user.conf

touch /usr/V/$CONTAINER_NAME/db/passdb.tdb
rm -/etc/samba/passdb.tdb
ln -s /usr/V/$CONTAINER_NAME/db/passdb.tdb /etc/samba/passdb.tdb

nmbd
smbd --configfile /etc/samba/smb-user.conf

sleep infinity &
wait $!
container_exit