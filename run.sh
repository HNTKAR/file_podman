#!/usr/bin/bash

mkdir -p -m 644 /log/NetBIOS_log /log/samba_log /log/log /conf/private /data
if [ ! -e /conf/smb.conf ];then
	cp /etc/samba/smb.conf /conf/smb.conf
	sed -i -e "s/tdbsam/tdbsam\n\tprivate dir = \/conf\/private/" /conf/smb.conf
fi

if [ -e  /usr/local/bin/setting.log ];then
	grep "^user" /usr/local/bin/setting.log | \
		sed -e "s/user://g" | \
		awk -F ':' '{print $1}' | \
		xargs -n 1 useradd
	grep "^user" /usr/local/bin/setting.log | \
		sed -e "s/user://g" | \
		awk -F ':' '{print $1" "$2}'| \
		xargs -n 2 bash -c 'echo -e "$1\n$1"|pdbedit -a -u $0 -s /conf/smb.conf'
	rm /usr/local/bin/setting.log
fi

pdbedit -L -s /conf/smb.conf|awk -F ':' '{print $1}'|xargs -n 1 useradd

#start rsyslog
rsyslogd

#start samba and NetBIOS
/usr/sbin/nmbd --daemon  -l /log/NetBIOS_log
/usr/sbin/smbd --foreground --log-basename /log/samba_log -s /conf/smb.conf 

tail -f /dev/null
