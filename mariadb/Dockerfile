FROM mariadb:10.6

ENV MARIADB_ROOT_PASSWORD="password"
COPY ["mariadb/my.cnf","/etc/mysql/"]

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

CMD [ "--socket" ,"/sock/mysql.sock"]