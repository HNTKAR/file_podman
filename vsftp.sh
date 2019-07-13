#!/usr/bin/bash

echo ""
echo `pwd`
ls
echo ""
while :
do
	read -p "do you copy directory ? (y/n):" yn
	if [ ${yn,,} = "y" ]; then
		echo "cp original_directory copy_directory"
		read -p "original_directory:" o_dir
		read -p "copy_directory:" c_dir
		rm -rf $c_dir
		cp -r $o_dir $c_dir
		directory=$c_dir
		break
	fi

	if [ ${yn,,} = "n" ]; then
		read -p "set your directory name :" directory
		break
	fi
done

cd $directory

read -p "set your server domain :" domain
read -p "set your server IP address :" ip
read -p "set vsftp home path :" path
sed -i s*mnt_dir*$path*g docker-compose.yml
sed -i s/server_name/$domain/g vsftpd.conf
sed -i s/user_ip/$ip/g vsftpd.conf

read -p "set your user name :" name
read -sp "set your user password :" pass
echo ""
echo -e "\nRUN useradd $name;\\">>Dockerfile
echo "echo $pass | passwd --stdin $name;\\">>Dockerfile
echo "echo mkdir -m 2777 -p $path/$name;\\">>Dockerfile
echo "echo "local_root=$path/$name/" >> /etc/vsftpd/vsftp_user_conf/$name">>Dockerfile
echo ""
read -p "does this user can root access  ? (y/n):" yn
if [ ${yn,,} = "y" ]; then
    echo "RUN echo $name >> /etc/vsftpd/chroot_list" >> Dockerfile
fi

while :
do
	read -p "do you add other user ? (y/n):" u_add

	if [ ${u_add,,} = "y" ]; then
		read -p "set your user name :" name
		read -sp "set your user password :" pass
		echo ""
		echo -e "\nRUN useradd $name;\\">>Dockerfile
		echo "echo $pass | passwd --stdin $name;\\">>Dockerfile
		echo "echo mkdir -m 2777 -p $path/$name;\\">>Dockerfile
		echo "echo "local_root=$path/$name/" >> /etc/vsftpd/vsftp_user_conf/$name">>Dockerfile
		echo ""
		read -p "does this user can root access  ? (y/n):" yn
		if [ ${yn,,} = "y" ]; then
    			echo "RUN echo $name >> /etc/vsftpd/chroot_list" >> Dockerfile
		fi
	fi

	if [ ${u_add,,} = "n" ]; then
		break
	fi
done


echo ""
read -p "do you want to up this container ? (y/n):" yn
if [ ${yn,,} = "y" ]; then
	docker-compose up --build -d
fi
