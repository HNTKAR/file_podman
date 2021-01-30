#!/bin/bash

#read setting file
sed -z -e "s/.*##\+samba#*//g" \
	-e "s/##.\+//g" setting.txt >setting.log

export domain=$(grep ^domain setting.log|sed "s/.*://")

#run container
read -p "do you want to up container ? (y/n):" yn
if [ ${yn,,} = "y" ]; then
	podman rmi -f samba
	podman build -f Dockerfile -t samba:latest --build-arg DOMAIN=$DOMAIN
fi

rm *.log
