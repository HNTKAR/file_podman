FROM docker.io/library/nginx:mainline
ARG CONFIG_FILE="Config/smb.conf"
VOLUME [ "/sock" ]

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN sed -i.back -e "/^user/ s/nginx/root/" /etc/nginx/nginx.conf
COPY ["${CONFIG_FILE}" ,"/etc/nginx/conf.d/"]