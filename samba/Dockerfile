FROM alpine

ENV TZ='Asia/Tokyo'
ENV CONF="/etc/samba/smb-user.conf"

RUN apk update
RUN apk upgrade

RUN ln -s /usr/share/zoneinfo/$TZ /etc/localtime

RUN apk add bash tzdata samba tdb
RUN addgroup samba

COPY ["samba/config/*", "/usr/local/lib/conf/"]
COPY ["samba/run.sh", "samba/smbuser", "/usr/local/bin/"]

RUN mv /usr/local/lib/conf/smb-user.conf  $CONF && \
    cat /usr/local/lib/conf/* >> $CONF

RUN chmod +x /usr/local/bin/*

RUN chmod 777 -R /usr/local/share/

ENTRYPOINT ["/usr/local/bin/run.sh"]
