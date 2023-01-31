#!/usr/bin/bash

USER=nextcloud
DATABASE=nextcloud_db
PASS=${PASS:-password}
echo $PASS > pass

if [ $(mysql -S /sock/mysql.sock -e "show databases"|grep $DATABASE|wc -l) -eq 0 ];then
    mysql -S /sock/mysql.sock -e "CREATE DATABASE $DATABASE DEFAULT CHARACTER SET utf8mb4"
    mysql -S /sock/mysql.sock -e "CREATE USER $USER@localhost IDENTIFIED BY '$PASS';"
    mysql -S /sock/mysql.sock -e "GRANT ALL ON $DATABASE.* TO $USER@localhost;"
    mysql -S /sock/mysql.sock -e "SHOW GRANTS FOR $USER@'localhost';"
fi