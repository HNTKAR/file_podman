#!/usr/bin/bash
nmbd -D && smbd -F
tail -f /dev/null
