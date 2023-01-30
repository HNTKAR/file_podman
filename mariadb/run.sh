#!/usr/bin/bash

rm -fr /sock/mysql.sock

if [ ! -d /data/performance_schema ];then
    mysql_install_db
fi

if [ $(grep memcache.local /var/www/nextcloud/nextcloud/config/config.php |wc -l) -eq 0 ];then
    sed -i -e "/^\$CONFIG/a 'memcache.local' => '\OC\Memcache\APCu'," \
        -e "/^\$CONFIG/a 'default_phone_region' =>'JP'," /var/www/nextcloud/nextcloud/config/config.php
fi

mariadbd --user root 