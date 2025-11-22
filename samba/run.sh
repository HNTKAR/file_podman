#!/bin/bash

mkdir -p /V/{conf,db,logs}
chown $(id -u):$(id -u) -R /V/{conf,db,logs}
chmod 777 -R /V/{conf,db,logs}

if [ -f /V/db/passwd.bak ]; then
    sed -i -e "/\/home\//d" /etc/passwd
    while IFS=: read -r user pass uid other; do
        adduser -D -u "$uid" -G samba -s /sbin/nologin "$user"
    done < /V/db/passwd.bak
fi

if [ -f /V/db/passdb.tdb ]; then
    cp /V/db/passdb.tdb /usr/local/lib/passdb.tdb
fi

nmbd
touch /V/conf/smb.conf /var/log/samba/smb.log
tail -F /var/log/samba/smb.log &
exec smbd --configfile $CONF --no-process-group --foreground
