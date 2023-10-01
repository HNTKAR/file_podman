FROM alpine

RUN apk update && \
    apk add tzdata mariadb-client
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY ["init/config.php.txt","/usr/local/src/"]
COPY ["init/nextcloud.sql","/usr/local/src/"]
COPY ["init/run.sh","/usr/local/bin/"]

RUN chmod 777 /usr/local/bin/run.sh

ENTRYPOINT [ "run.sh" ]
# ENTRYPOINT [ "tail" ]
# CMD [ "-f" ]