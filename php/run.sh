#!/usr/bin/bash

crond
chown root:root -R /var/www/nextcloud/
exec /opt/remi/php$PHP_VER/root/usr/sbin/php-fpm --nodaemonize --allow-to-run-as-root
