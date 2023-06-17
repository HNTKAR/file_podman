#!/usr/bin/bash

if [ ! -e /var/www/nextcloud/config/config.php ];then
echo "<?php
\$CONFIG = array (
);" >/var/www/nextcloud/config/config.php
fi

if [ $(grep Memcache /var/www/nextcloud/config/config.php |wc -l) -eq 0 ];then
    sed -i.old -e "/^\$CONFIG/a 'filelocking.enabled' => true,\n'memcache.locking' => '\\\OC\\\Memcache\\\Redis',\n'redis'    => array(\n'host'     => '/sock/redis.sock',\n'port'     => 0,\n'timeout'  =>0.0,\n)," /var/www/nextcloud/config/config.php
    sed -i.old -e "/^\$CONFIG/a 'memcache.distributed' => '\\\OC\\\Memcache\\\Redis',\n'memcache.local' => '\\\OC\\\Memcache\\\Redis',\n'redis' => [\n'host'     => '/sock/redis.sock',\n'port'     => 0,\n]," /var/www/nextcloud/config/config.php
fi

rm -fr /sock/redis.sock 
exec /usr/bin/redis-server /etc/redis/redis.conf --daemonize no 
