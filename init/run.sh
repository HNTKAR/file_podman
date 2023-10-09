#!/bin/sh

# config.php の生成まで待機
while [ ! -e "/var/www/nextcloud/config/config.php" ]; do
    sleep 1
done

# /sock/mysqld.sock の生成まで待機
while [ ! -e "/sock/mysql.sock" ]; do
    sleep 1
done

pass="password"
user="root"
num=$(
    grep ^\$CONFIG -n /var/www/nextcloud/config/config.php |
        sed "s/:.*//g" |
        head -n 1
)

if [ $(mysql -u${user} -p${pass} -S /sock/mysql.sock -e"show databases;" | grep nextcloud_db | wc -l) -eq 0 ]; then
    mysql -u${user} -p${pass} -S /sock/mysql.sock </usr/local/src/nextcloud.sql
fi

if [ $(cat /var/www/nextcloud/config/config.php | grep default_phone_region | wc -l) -eq 0 ]; then
    sed -i "${num} r /usr/local/src/config.php.txt" /var/www/nextcloud/config/config.php
fi

chown root:root -R /var/www/nextcloud
