FROM mariadb:10.11

ENV MARIADB_RANDOM_ROOT_PASSWORD="true"
ENV TZ='Asia/Tokyo'

COPY ["my.cnf","/etc/mysql/conf.d/99-user.cnf"]
COPY ["nextcloud.sql","/docker-entrypoint-initdb.d/00-nextcloud.sql"]