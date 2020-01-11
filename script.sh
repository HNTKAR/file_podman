#!/bin/bash

#read setting file
sed -z s/.*#general//  setting.txt |
	\sed -z s/#.*// |
	\sed -e /^$/d >general.log
sed -z s/.*#vsftp//  setting.txt |
	\sed -z s/#.*// |
	\sed -e /^$/d |
	\sed '1d' >setting_vsftp.log
domain=$(cat general.log |grep your_domain|cut -f 2 -d ":")
global_ip=$(cat general.log |grep your_global_ip|cut -f 2 -d ":")

#echo general settings
echo "domain=$domain"
echo "global_ip=$global_ip"

#make default smb.conf
echo -e """anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
xferlog_std_format=YES
chroot_local_user=YES
chroot_list_enable=YES
listen=YES
listen_ipv6=NO

pam_service_name=vsftpd
userlist_enable=YES
tcp_wrappers=YES""">vsftpd.conf

#set private setting
echo -e """chroot_local_user=YES
chroot_list_enable=YES
pasv_address=$global_ip
rsa_cert_file=/etc/letsencrypt/live/ftp.$domain/fullchain.pem
rsa_private_key_file=/etc/letsencrypt/live/ftp.$domain/privkey.pem
ssl_enable=YES
pasv_min_port=10000
pasv_max_port=10050
require_ssl_reuse=NO
user_config_dir=/etc/vsftpd/vsftp_user_conf
allow_writeable_chroot=YES
""">>vsftpd.conf
cat setting_vsftp.log |awk -F ":" -f script.awk
wait

#write files
echo -e "\nENTRYPOINT [\"/usr/local/bin/run.sh\"]">>Dockerfile
echo -e "    image: vsftp\n    container_name: vsftp">>docker-compose.yml

#cleaning
rm *.log
echo "ok!!"

#run container
echo ""
read -p "do you want to up this container ? (y/n):" yn
if [ ${yn,,} = "y" ]; then
	docker-compose up --build -d
fi
