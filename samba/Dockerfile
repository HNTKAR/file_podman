FROM alpine

ENV TZ='Asia/Tokyo'
ENV POD_NAME="file-pod"
ENV CONTAINER_NAME="file-samba"
ENV CONF="/etc/samba/smb-user.conf"

RUN apk update
RUN apk upgrade

RUN ln -s /usr/share/zoneinfo/$TZ /etc/localtime

RUN apk add bash tzdata samba
RUN addgroup -S samba && \
    adduser -S -D -G samba sample

COPY ["samba/run.sh", "samba/smbuser", "/usr/local/bin/"]
COPY ["samba/smb-user.conf", "/etc/samba/smb-user.conf"]
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/run.sh"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]
