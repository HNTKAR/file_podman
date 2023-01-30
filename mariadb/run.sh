#!/usr/bin/bash

rm -fr /sock/mysql.sock

if [ ! -d /data/performance_schema ];then
    mysql_install_db
fi

mariadbd --user root 