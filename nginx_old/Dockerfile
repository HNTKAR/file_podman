FROM nginx:mainline

ARG CONFIG_FILE="https://raw.githubusercontent.com/nextcloud/documentation/master/admin_manual/installation/nginx-root.conf.sample"
ENV TZ='Asia/Tokyo'

VOLUME [ "/sock" ]

ADD ["${CONFIG_FILE}" ,"/etc/nginx/conf.d/nextcloud.conf"]