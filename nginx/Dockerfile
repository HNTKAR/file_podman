FROM nginx:mainline-alpine

ARG CONFIG_FILE="https://raw.githubusercontent.com/nextcloud/documentation/master/admin_manual/installation/nginx-root.conf.sample"
VOLUME [ "/sock" ]

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN sed -i.back -e "/^user/ s/nginx/root/" /etc/nginx/nginx.conf
ADD ["${CONFIG_FILE}" ,"/etc/nginx/conf.d/nextcloud.conf"]