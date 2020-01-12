docker-compose up --build -d
firewall-cmd --direct --add-rule ipv4 filter DOCKER-USER 1 ! -s 192.168.0.0/16 -p tcp --dport 139 -j DROP
firewall-cmd --direct --add-rule ipv4 filter DOCKER-USER 1 ! -s 192.168.0.0/16 -p tcp --dport 445 -j DROP
firewall-cmd --direct --add-rule ipv4 filter DOCKER-USER 1 ! -s 192.168.0.0/16 -p udp --dport 137 -j DROP
firewall-cmd --direct --add-rule ipv4 filter DOCKER-USER 1 ! -s 192.168.0.0/16 -p udp --dport 138 -j DROP
