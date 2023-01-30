FROM rockylinux:9

RUN unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime

RUN dnf -y update && \
    dnf -y install mariadb-server

RUN mkdir /data && \
    chmod 777 -R /data && \
    sed -i -e "s@datadir=.*@datadir=/database@g" \
        -e "s@socket=.*@socket=/sock/mysql.sock@g" /etc/my.cnf.d/mariadb-server.cnf 

COPY ["mariadb/run.sh", "/usr/local/bin/"]
RUN chmod 777 -R /usr/local/bin/ 
ENTRYPOINT ["/usr/local/bin/run.sh"]