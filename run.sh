#!/usr/bin/bash
/usr/sbin/smbd --foreground --no-process-group
tail -f /dev/null
