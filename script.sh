#!/bin/bash

cd $(dirname $0)

#read setting file
sed -z -e "s/.*##\+file#*//g" \
	-e "s/##.\+//g" setting.txt > setting.log

export SSL_DOMAIN=$(grep ^ssl_domain setting.log|sed "s/.*://")
export USER_DOMAIN=$(grep ^hostname setting.log|sed "s/.*://")
export GLOBAL_IP=$(grep ^global_ip setting.log|sed "s/.*://")

#run container
read -p "do you want to up local file container ? (y/n):" yn
if [ ${yn,,} = "y" ]; then
	podman rmi -f samba
	podman build -f Dockerfile-samba -t samba
fi

read -p "do you want to up ftp container ? (y/n):" yn
if [ ${yn,,} = "y" ]; then
	podman rmi -f samba vsftp
	podman build -f Dockerfile-vsftp -t vsftp --build-arg SSL_DOMAIN=$SSL_DOMAIN --build-arg USER_DOMAIN=$USER_DOMAIN --build-arg GLOBAL_IP=$GLOBAL_IP
fi

rm *.log
