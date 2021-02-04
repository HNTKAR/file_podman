# local file server Container

## _setting file format_

```
###file###
ssl_domain:example.com
global_ip:203.0.113.1
hostname:example.org
user:USER1:PASSWORD1
user:USER2:PASSWORD2
user:USER3:PASSWORD3
```

## _up container_

both
```
podman pod create --replace=true -p 10137:137/udp -p 10138:138/udp -p 10139:139 -p 10445:445 -p 10021:21 -p 50000-50050:10000-10050 -n file_pod --net slirp4netns:port_handler=slirp4netns
sudo mkdir -p -m 777 /home/podman/file_pod/local_conf /home/podman/data /home/podman/file_pod/local_log /home/podman/file_pod/global_conf /home/podman/data /home/podman/lofile_pod/global_log
./script.sh
sudo firewall-cmd --add-forward-port=port=137:proto=udp:toport=10137 --permanent
sudo firewall-cmd --add-forward-port=port=138:proto=udp:toport=10138 --permanent
sudo firewall-cmd --add-forward-port=port=139:proto=tcp:toport=10139 --permanent
sudo firewall-cmd --add-forward-port=port=445:proto=tcp:toport=10445 --permanent
sudo firewall-cmd --add-forward-port=port=21:proto=tcp:toport=10021 --permanent
sudo firewall-cmd --add-forward-port=port=10000-10050:proto=tcp:toport=50000-50050 --permanent
sudo firewall-cmd --reload
cat tmp.service | \
xargs -I {} systemctl --user disable {}
cat tmp.service | \
xargs -I {} cp {} -frp $HOME/.config/systemd/user && \
cat tmp.service | \
xargs -I {} systemctl --user enable {}
mkdir -p $HOME/.config/systemd/user/ && \
podman generate systemd --new -n --restart-policy=always file_pod -f >tmp.service && \
systemctl --user restart pod-file_pod
```

local
```
podman run --replace=true -td --pod file_pod -v /home/podman/lofile_pod/local_conf:/conf -v /home/podman/data:/data -v /home/podman/lofile_pod/local_log:/log --name samba samba
#podman exec -it samba bash
```

global
```
cat tmp.service | \
xargs -I {} systemctl --user disable {}
podman run --replace=true -td --pod lofile_pod -v /home/podman/lofile_pod/global_conf:/conf -v /home/podman/data:/data -v /home/podman/lofile_pod/global_log:/log --name vsftp vsftp
#podman exec -it vsftp bash
```
