#!/usr/bin/bash

chown -R mysql:mysql /var/lib/mysql
rm -fr /var/lib/mysql/mysql.sock

if [ ! -d /data/performance_schema ];then
    sudo -u mysql mysql_install_db
fi

sudo -u mysql mariadbd  