# file server Container

## **設定ファイル**

```
###file###
ssl_domain:example.com
global_ip:203.0.113.1
hostname:example.org
user:USER1:PASSWORD1
user:USER2:PASSWORD2
user:USER3:PASSWORD3
```

## **コンテナの起動**
```
sudo firewall-cmd --add-port=20000-20050/tcp --permanent
sudo firewall-cmd --add-forward-port=port=21:proto=tcp:toport=10021 --permanent
sudo firewall-cmd --add-forward-port=port=137:proto=udp:toport=10137 --permanent
sudo firewall-cmd --add-forward-port=port=138:proto=udp:toport=10138 --permanent
sudo firewall-cmd --add-forward-port=port=139:proto=tcp:toport=10139 --permanent
sudo firewall-cmd --add-forward-port=port=445:proto=tcp:toport=10445 --permanent
sudo firewall-cmd --reload
sudo mkdir -p -m 777 /home/podman/data /home/podman/file_pod/local_conf /home/podman/file_pod/local_log /home/podman/file_pod/global_conf /home/podman/file_pod/global_log
./script.sh
podman pod create --replace=true -p 10137:137/udp -p 10138:138/udp -p 10139:139 -p 10445:445 -p 10021:21 -p 20000-20050:20000-20050 -n file_pod --net slirp4netns:port_handler=slirp4netns
podman run --replace=true -td --pod file_pod -v /home/podman/file_pod/local_conf:/conf -v /home/podman/data:/data -v /home/podman/file_pod/local_log:/log --name samba samba
podman run --replace=true -td --pod file_pod -v /home/podman/file_pod/global_conf:/conf -v /home/podman/data:/data -v /home/podman/file_pod/global_log:/log --name vsftp vsftp
```

## **ファイルおよびフォルダ**
 samba  
> * /home/podman/file_pod/local_conf/smb.conf  
>>  smbd用基本設定ファイル ( default : /etc/samba/smb.conf )
> 
> * /home/podman/file_pod/local_conf/private/  
>> ユーザー管理データベース ( default : /var/lib/samba/private/ )  
>> 手動で新規ユーザーを追加する場合はコンテナ内で以下のコマンドを使用する
>> ```
>> user add USER_NAME
>> pdbedit -a -u USER_NAME -s /conf/smb.conf
>> ```  
>
> * /home/podman/file_pod/local_log/  
>> 各種ログ ( default : /var/log/ )

> vsftp
> * /home/podman/file_pod/global_conf/vsftpd.conf  
>> vsftpd用基本設定ファイル  ( default /etc/vsftpd/vsftpd.conf )  
> 
> * /home/podman/file_pod/global_conf/vsftp_user_conf/USER_NAME  
>> ユーザー個別設定ファイル ( default : /etc/vsftpd/userconf/USER_NAME )  
>> ここに書かれた設定がユーザーごとに適用される  
>> /etc/vsftpd/userconf/USER1 の例
>> ```
>> local_root=/data/user1_dir
>> write_enable=YES
>> ```
> * /home/podman/file_pod/global_conf/vsftpd.chroot_list  
>> 非chrootユーザー設定ファイル ( default : /etc/vsftpd/vsftpd.chroot_list )  
>> ここに書かれたユーザーはchrootの影響を受けない  
>> vsftpd.chroot_list の例
>> ``` 
>> USER1
>> USER2
>> ```
> * /home/podman/file_pod/global_log/  
>> 各種ログ ( default : /var/log/ )

### 自動起動の設定
```
mkdir -p $HOME/.config/systemd/user/
podman generate systemd -f -n --new --restart-policy=always file_pod >tmp.service
systemctl --user start pod-file_pod
cat tmp.service | \
xargs -I {} \cp {} -frp $HOME/.config/systemd/user
cat tmp.service | \
xargs -I {} systemctl --user enable {}
```

### 自動起動解除
```
cat tmp.service | \
xargs -I {} systemctl --user disable {}
```
