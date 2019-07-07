#!/usr/bin/bash

echo ""
echo `pwd`
echo `ls /mnt`
ls
echo ""
while :
do
	read -p "do you copy directory ? (y/n):" yn
	if [ ${yn,,} = "y" ]; then
		echo "cp original_directory copy_directory"
		read -p "original_directory:" o_dir
		echo o_dir=$o_dir
		read -p "copy_directory:" c_dir
		echo c_dir=$c_dir
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

read -p "set your local ip (ex.192.168.xxx.):" ip
read -p "set samba home path :" path
echo "hosts allow = $ip">>smb.conf
echo ""

read -p "set your user name :" name
read -sp "set your user password :" pass
echo ""
read -p "who can login your directory ? :" dir_user

echo -e "\nRUN useradd $name;\\">>Dockerfile
echo "echo $pass | passwd --stdin $name;\\">>Dockerfile
echo "echo -e \"$pass\\n$pass\" | pdbedit -a -t -u \"$name\"">>Dockerfile
echo "[$name]">>smb.conf
echo "path = $path/$name">>smb.conf
echo "browsable = no">>smb.conf
echo "read only = no">>smb.conf
echo "create mode = 0744">>smb.conf
echo "directory mode = 0744">>smb.conf
echo "valid users = $dir_user">>smb.conf
echo "">>smb.conf
echo ""

while :
do
	read -p "do you add other user ? (y/n):" u_add
	if [ ${u_add,,} = "y" ]; then
	read -p "set your user name :" name
	read -sp "set your user password :" pass
	echo ""
	read -p "who can login your directory ? :" dir_user

	echo -e "\nRUN useradd $name;\\">>Dockerfile
	echo "echo $pass | passwd --stdin $name;\\">>Dockerfile
	echo "echo -e \"$pass\\n$pass\" | pdbedit -a -t -u \"$name\"">>Dockerfile
	echo "[$name]">>smb.conf
	echo "path = $path/$name">>smb.conf
	echo "browsable = no">>smb.conf
	echo "read only = no">>smb.conf
	echo "create mode = 0744">>smb.conf
	echo "directory mode = 0744">>smb.conf
	echo "valid users = $dir_user">>smb.conf
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
