#!/bin/bash

#read setting file
sed -z s/.*#samba//  setting.txt |
	\sed -z s/#.*// |
	\sed -e /^$/d |
	\sed '1d' >setting_samba.log

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
firewall-cmd --direct --add-rule ipv4 filter DOCKER-USER 1 ! -s 192.168.0.0/16 -p tcp --dport 139 -j DROP
firewall-cmd --direct --add-rule ipv4 filter DOCKER-USER 1 ! -s 192.168.0.0/16 -p tcp --dport 445 -j DROP
firewall-cmd --direct --add-rule ipv4 filter DOCKER-USER 1 ! -s 192.168.0.0/16 -p udp --dport 137 -j DROP
firewall-cmd --direct --add-rule ipv4 filter DOCKER-USER 1 ! -s 192.168.0.0/16 -p udp --dport 138 -j DROP
#run container
echo ""
read -p "do you want to up this container ? (y/n):" yn
if [ ${yn,,} = "y" ]; then
	docker-compose up --build -d
fi
