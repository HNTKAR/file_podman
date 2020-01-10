#!/bin/bash

#read setting file
sed -z s/.*#samba//  setting.txt |
	\sed -z s/#.*// |
	\sed -e /^$/d |
	\sed '1d' >setting_samba.log
sed -z s/.*#general// setting.txt |
	\sed -z s/#.*// |
	\sed -e /^$/d |
	\sed '1d' >general.log

#make default smb.conf
echo -e "[global]">smb.conf
echo -e "\tworkgroup = WORKGROUP">>smb.conf
echo -e "\tsecurity = user">>smb.conf
echo -e "\tpassdb backend = tdbsam">>smb.conf
echo -e "\tprinting = cups">>smb.conf
echo -e "\tprintcap name = cups">>smb.conf
echo -e "\tload printers = no">>smb.conf
echo -e "\tcups options = raw">>smb.conf
echo -e "\twins support = yes">>smb.conf

#set local IP
#awk -F "." '{print "\thosts allow = "$1"."$2"."$3".">>"smb.conf"}' general.log

#set private setting
cat setting_samba.log |awk -F ":" -f script.awk
wait

#write files
echo -e "\nENTRYPOINT [\"/usr/local/bin/run.sh\"]">>Dockerfile
echo -e "    image: samba\n    container_name: samba">>docker-compose.yml

#cleaning
rm *.log
echo "ok!!"

#iptables
iptables -I DOCKER-USER ! -s 192.168.0.0/16 -p tcp --sport 139 -j ACCEPT
iptables -I DOCKER-USER ! -s 192.168.0.0/16 -p tcp --sport 445 -j ACCEPT
iptables -I DOCKER-USER ! -s 192.168.0.0/16 -p udp --sport 137 -j ACCEPT
iptables -I DOCKER-USER ! -s 192.168.0.0/16 -p udp --sport 138 -j ACCEPT

#run container
echo ""
read -p "do you want to up this container ? (y/n):" yn
if [ ${yn,,} = "y" ]; then
	docker-compose up --build -d
fi
