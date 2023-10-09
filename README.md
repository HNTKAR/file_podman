# はじめに
環境は以下の状態を想定する
|名称|値|
|:-:|:-:|
|ポッド名|file|
|localtime|Asia/Tokyo|
|DB root password|password|
|nextcloud DB name|nextcloud_db|
|nextcloud DB user|nextcloud_user|
|nextcloud DB password|nextcloud_password|

# 実行スクリプト

## はじめに
nextcloud本体のファイルをダウンロードする。
```bash
curl https://download.nextcloud.com/server/releases/latest.tar.bz2 -o $HOME/latest.tar.bz2
```

## 各種コンテナの起動
```bash
cd file_podman

# 変数の設定
ContainerBranch="alpine"

# ボリュームの作成
podman volume create file_nginx_dir
bunzip2 -k -c $HOME/latest.tar.bz2 |
    podman volume import file_nginx_dir -
podman volume create file_mariadb_dir

# ポッドの作成
podman pod create --replace --publish 11080:11080 --publish 11443:11443 --network=slirp4netns:port_handler=slirp4netns --name file

#nginx
podman build --build-arg CONFIG_FILE=Config/nextcloud.conf --tag file-nginx:$ContainerBranch --file nginx/Dockerfile .
podman run --detach --replace --mount type=volume,source=file_nginx_dir,destination=/var/www --pod file --name file-nginx file-nginx:$ContainerBranch

# php
podman build --tag file-php:$ContainerBranch --file php/Dockerfile .
podman run --detach --replace --volumes-from file-nginx --pod file --name file-php file-php:$ContainerBranch

# mariadb
podman build --tag file-mariadb:$ContainerBranch --file mariadb/Dockerfile .
podman run --detach --replace --volumes-from file-nginx --mount type=volume,source=file_mariadb_dir,destination=/var/lib/mysql --pod file --name file-mariadb file-mariadb:$ContainerBranch

# redis
podman build --tag file-redis:$ContainerBranch --file redis/Dockerfile .
podman run --detach --replace --volumes-from file-nginx --pod file --name file-redis file-redis:$ContainerBranch

# postfix
podman build --tag file-postfix:$ContainerBranch --file postfix/Dockerfile .
podman run --detach --replace --pod file --name file-postfix file-postfix:$ContainerBranch

# initializer
podman build --tag file-init:$ContainerBranch --file init/Dockerfile .
podman run --detach --replace --volumes-from file-nginx --pod file --name file-init file-init:$ContainerBranch
```

# 自動起動の設定
```sh
# rootコンテナの場合
sudo podman generate systemd -f -n --new --restart-policy=always file >tmp.service
cat tmp.service | \
xargs -I {} sudo cp {} -frp /etc/systemd/system/
sed -e "s/.*\///g" tmp.service | \
grep pod | \
xargs -n 1 sudo systemctl --now enable

# rootlessコンテナの場合
podman generate systemd -f -n --new --restart-policy=always file >tmp.service
mkdir -p ~/.config/systemd/user/
cat tmp.service | \
xargs -I {} cp {} -frp ~/.config/systemd/user/
sed -e "s/.*\///g" tmp.service | \
grep pod | \
xargs -n 1 systemctl --user enable --now
```

# 自動起動解除
```sh
# rootコンテナの場合
sed -e "s/.*\///g" tmp.service | \
grep pod | \
xargs -n 1 sudo systemctl --user disable --now

# rootlessコンテナの場合
sed -e "s/.*\///g" tmp.service | \
grep pod | \
xargs -n 1 systemctl --user disable --now
```
