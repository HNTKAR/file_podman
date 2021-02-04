#!/usr/bin/bash

mkdir -p -m 644 /log /conf
if [ ! -e /conf/vsftpd.conf ];then
	cp /etc/vsftpd/vsftpd.conf /conf/vsftpd.conf
fi

/usr/sbin/vsftpd /conf/vsftpd.conf
tail -f /dev/null
