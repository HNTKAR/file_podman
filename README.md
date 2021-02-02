# local file server Container

## _setting file format_

```
###samba###
domain:example.com
```

## _up container_

```
sudo mkdir -p -m 777 /home/podman/lofile_pod/conf_and_log  /home/podman/lofile_pod/data
./script.sh
sudo firewall-cmd --add-forward-port=port=139:proto=tcp:toport=10139 --permanent
sudo firewall-cmd --add-forward-port=port=445:proto=tcp:toport=10445 --permanent
sudo firewall-cmd --add-forward-port=port=137:proto=tcp:toport=10137 --permanent
sudo firewall-cmd --add-forward-port=port=138:proto=tcp:toport=10138 --permanent
sudo firewall-cmd --reload
cat tmp.service | \
xargs -I {} systemctl --user disable {}
podman pod create --replace=true -p 10139:139 -p 10445:445 -p 10137:137 -p 10138:138 -n lofile_pod
podman run --replace=true -td --pod lofile_pod -v /home/podman/lofile_pod/conf_and_log:/conf -v /home/podman/lofile_pod/data:/home --name samba samba
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
