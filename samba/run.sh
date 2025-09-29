#!/bin/bash

container_exit() {
    exit 0
}

trap "container_exit" SIGTERM

mkdir -p /usr/V/$CONTAINER_NAME/{conf,db,logs,share}
chown $(id -u):$(id -u) -R /usr/V/$CONTAINER_NAME/{conf,db,logs}
chmod 777 -R /usr/V/$CONTAINER_NAME/{conf,db,logs}
chmod 777 /usr/V/$CONTAINER_NAME/share

if [ -f "/usr/V/$CONTAINER_NAME/db/passwd.bak" ]; then
    sed -i -e "/home/d" /etc/passwd
    grep "home" /usr/V/$CONTAINER_NAME/db/passwd.bak >> /etc/passwd
fi

if [ -f "/usr/V/$CONTAINER_NAME/db/group.bak" ]; then
    sed -i -e "/sample/d" /etc/group
    grep "samba" /usr/V/$CONTAINER_NAME/db/group.bak >> /etc/group
fi

if [ -f "/usr/V/$CONTAINER_NAME/db/passdb.tdb.bak" ]; then
    rm /etc/samba/passdb.tdb
    cp /usr/V/$CONTAINER_NAME/db/passdb.tdb.bak /etc/samba/passdb.tdb
fi

echo -e "password\npassword"|pdbedit --create --password-from-stdin --user sample --configfile $CONF

touch /usr/V/$CONTAINER_NAME/db/passdb.tdb
# pdbedit -i tdbsam:/usr/V/$CONTAINER_NAME/db/passdb.tdb --configfile $CONF 2> /dev/null

nmbd
touch /usr/V/$CONTAINER_NAME/conf/smb.conf
smbd --configfile $CONF

sleep infinity &
wait $!
container_exit