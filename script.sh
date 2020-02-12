#!/bin/bash

#read setting file
sed -z s/.*#samba//  setting.txt |
	\sed -z s/#.*// |
	\sed -e /^$/d |
	\sed '1d' >setting_samba.log

#make default smb.conf
echo -e """[global]
\tworkgroup = WORKGROUP
\tsecurity = user
\tpassdb backend = tdbsam
\tprinting = cups
\tprintcap name = cups
\tload printers = no
\tcups options = raw
\twins support = yes""">>smb.conf

#set private setting
cat setting_samba.log |awk -F ":" -f script.awk
wait

#set network setting
echo -e """networks:
  default:
    external:
      name: default_bridge
"""

#write files
echo -e "\nENTRYPOINT [\"/usr/local/bin/run.sh\"]">>Dockerfile

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
