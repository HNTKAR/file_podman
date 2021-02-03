#!/usr/bin/bash

mkdir -p -m 644 /log/NetBIOS_log /log/samba_log /log/log /conf/private /data
if [ ! -e /conf/smb.conf ];then
	cp /etc/samba/smb.conf /conf/smb.conf
	sed -i -e "s/tdbsam/tdbsam\n\tprivate dir = \/conf\/private/" /conf/smb.conf
fi
pdbedit -L -s /conf/smb.conf|awk -F ':' '{print $1}'|xargs -n 1 useradd

#start rsyslog
rsyslogd

#start samba and NetBIOS
#/usr/sbin/nmbd --daemon  -l /conf/NetBIOS_log
/usr/sbin/smbd --foreground --log-basename /conf/samba_log -s /conf/smb.conf

tail -f /dev/null
