#!/usr/bin/bash

if [ ! -e /conf/smb.conf ];then
	cp /etc/samba/smb.conf /conf/smb.conf
fi

#start rsyslog
rsyslogd

#start samba and NetBIOS
/usr/sbin/nmbd --daemon  -l /conf/NetBIOS_log
/usr/sbin/smbd --foreground --log-basename /conf/samba_log -s /conf/smb.conf
tail -f /dev/null
