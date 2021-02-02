#!/usr/bin/bash

#start rsyslog
rsyslogd

#start samba
/usr/sbin/nmbd --daemon
/usr/sbin/smbd --foreground
