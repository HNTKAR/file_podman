FROM alpine

ENV TZ='Asia/Tokyo'
ENV POD_NAME="file-pod"
ENV CONTAINER_NAME="file-samba"
ENV CONF="/etc/samba/smb-user.conf"

RUN apk update
RUN apk upgrade

RUN ln -s /usr/share/zoneinfo/$TZ /etc/localtime

RUN apk add bash tzdata samba tdb
RUN addgroup samba

COPY ["samba/config/*", "/etc/samba/"]
COPY ["samba/run.sh", "samba/smbuser", "/usr/local/bin/"]
COPY ["samba/smb-user.conf", "/etc/samba/smb-user.conf"]

RUN touch /etc/samba/smb-include.conf
RUN chmod +x /usr/local/bin/*

RUN chmod 777 -R /usr/local/share/

ENTRYPOINT ["/usr/local/bin/run.sh"]
