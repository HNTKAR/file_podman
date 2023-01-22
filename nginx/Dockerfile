FROM rockylinux:9

ARG CONFIG_FILE="nginx.conf"
ARG NEXTCLOUD_DATA="https://download.nextcloud.com/server/releases/latest.tar.bz2"

COPY ["nginx/nginx.repo","/etc/yum.repos.d/"]
RUN dnf -y update && dnf -y install nginx vim

ADD ["${NEXTCLOUD_DATA}","/var/www"]
ADD ["nginx/nginx_user.conf","/etc/nginx"]
ADD ["${CONFIG_FILE}","/etc/nginx/conf_user.d/"]
COPY ["nginx/run.sh", "/usr/local/bin/"]
RUN chmod 777 -R /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run.sh"]