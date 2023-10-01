#!/bin/sh

# config.phpの生成まで待機
sleep 30

pass="password"
user="root"
num=$( \
    grep ^\$CONFIG -n /var/www/nextcloud/config/config.php | \
    sed "s/:.*//g" | \
    head -n 1 \
    )

chown root:root -R /var/www/nextcloud

mysql -u${user} -p${pass} -S /sock/mysql.sock < /usr/local/src/nextcloud.sql

sed -i "${num} r /usr/local/src/config.php.txt" /var/www/nextcloud/config/config.php
