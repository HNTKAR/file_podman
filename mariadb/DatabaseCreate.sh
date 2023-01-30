#!/usr/bin/bash

PASSWOED=$1
USER=nextcloud
DATABASE=nextcloud

mysql -S /sock/mysql.sock -e "CREATE DATABASE nextcloud DEFAULT CHARACTER SET utf8mb4"
mysql -S /sock/mysql.sock -e "CREATE USER 'nextcloud'@'localhost' IDENTIFIED BY 'nextcloud';"
mysql -S /sock/mysql.sock -e "GRANT ALL ON nextcloud.* TO 'nextcloud'@'localhost';"
mysql -S /sock/mysql.sock -e "SHOW GRANTS FOR 'nextcloud'@'localhost';"