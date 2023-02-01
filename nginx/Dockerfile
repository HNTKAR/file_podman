FROM rockylinux:9

ARG CONFIG_FILE="nginx.conf"

RUN unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime

VOLUME [ "/sock" ]
COPY ["nginx/nginx.repo","/etc/yum.repos.d/"]
RUN dnf -y update && \
    dnf -y install nginx

ADD ["nginx/nginx_user.conf","/etc/nginx"]
ADD ["${CONFIG_FILE}","/etc/nginx/conf_user.d/"]
COPY ["nginx/run.sh", "/usr/local/bin/"]
RUN chmod 777 -R /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run.sh"]