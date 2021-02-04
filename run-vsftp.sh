#!/usr/bin/bash

mkdir -p -m 644 /log /conf /log/log /conf/vsftp_user_conf /data
touch /conf/vsftpd.chroot_list
if [ ! -e /conf/vsftpd.conf ];then
	cp /etc/vsftpd/vsftpd.conf /conf/vsftpd.conf
fi
if [ -e  /usr/local/bin/setting.log ];then
	grep "^user" /usr/local/bin/setting.log | \
		sed -e "s/user://g" | \
		awk -F ':' '{print $1}' | \
		xargs -n 1 useradd
	grep "^user" /usr/local/bin/setting.log | \
		sed -e "s/user://g" | \
		awk -F ':' '{print $1" "$2}'| \
		xargs -n 2 bash -c 'echo -e "$1"| passwd --stdin "$0"'
	rm /usr/local/bin/setting.log
fi


/usr/sbin/vsftpd /conf/vsftpd.conf
tail -f /dev/null
