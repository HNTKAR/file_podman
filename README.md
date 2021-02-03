# local file server Container

## _setting file format_

```
###samba###
user:USER1:PASSWORD1
user:USER2:PASSWORD2
user:USER3:PASSWORD3
```

## _up container_

```
podman pod create --replace=true -p 10137:137/udp -p 10138:138/udp -p 10139:139 -p 10445:445 -n lofile_pod --net slirp4netns:port_handler=slirp4netns
sudo mkdir -p -m 777 /home/podman/lofile_pod/conf /home/podman/data /home/podman/lofile_pod/log
./script.sh
sudo firewall-cmd --add-forward-port=port=137:proto=udp:toport=10137 --permanent
sudo firewall-cmd --add-forward-port=port=138:proto=udp:toport=10138 --permanent
sudo firewall-cmd --add-forward-port=port=139:proto=tcp:toport=10139 --permanent
sudo firewall-cmd --add-forward-port=port=445:proto=tcp:toport=10445 --permanent
sudo firewall-cmd --reload
cat tmp.service | \
xargs -I {} systemctl --user disable {}
podman run --replace=true -td --pod lofile_pod -v /home/podman/lofile_pod/conf:/conf -v /home/podman/data:/data -v /home/podman/lofile_pod/log:/log --name samba samba
mkdir -p $HOME/.config/systemd/user/ && \
podman generate systemd --new -n --restart-policy=always lofile_pod -f >tmp.service && \
cat tmp.service | \
xargs -I {} cp {} -frp $HOME/.config/systemd/user && \
cat tmp.service | \
xargs -I {} systemctl --user enable {}
podman pod rm -f lofile_pod
systemctl --user restart pod-lofile_pod
#podman exec -it samba bash
```
