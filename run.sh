#!/usr/bin/bash

if [ ! -e /conf/smb.conf ];then
	cp /etc/samba/smb.conf /conf/smb.conf
	sed -i -e "s/tdbsam/tdbsam\n\tprivate dir = \/conf\/private/" /conf/smb.conf
fi
mkdir -p -m 644 /conf/NetBIOS_log /conf/samba_log /conf/private

#start rsyslog
rsyslogd

#start samba and NetBIOS
/usr/sbin/nmbd --daemon  -l /conf/NetBIOS_log
/usr/sbin/smbd --foreground --log-basename /conf/samba_log -s /conf/smb.conf
tail -f /dev/null
