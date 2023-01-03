#!/usr/bin/bash

pdbedit -L | awk -F ":" '{print $1}' | xargs -n 1 useradd -s /sbin/nologin

# /usr/sbin/nmbd --daemon  -l /log/NetBIOS_log
smbd --configfile=/etc/samba/smb-user.conf --foreground --no-process-group
