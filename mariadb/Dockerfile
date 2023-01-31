FROM rockylinux:9

ARG DATABASE_PASSWORD=password
ENV PASS=${DATABASE_PASSWORD}

RUN unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime

RUN dnf -y update && \
    dnf -y install mariadb-server

RUN mkdir /database /sock && \
    sed -i.old -e "s@datadir=.*@datadir=/database@g" \
        -e "s@socket=.*@socket=/sock/mysql.sock@g" /etc/my.cnf.d/mariadb-server.cnf 

COPY ["mariadb/run.sh", "mariadb/DatabaseCreate.sh", "/usr/local/bin/"]
RUN chmod 777 -R /usr/local/bin/ 
ENTRYPOINT ["/usr/local/bin/run.sh"]