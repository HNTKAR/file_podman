FROM rockylinux:9

RUN unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime

RUN dnf -y update && \
    dnf -y install mariadb-server sudo 

RUN mkdir /data && \
    chmod 777 -R /data && \
    chown -R mysql:mysql /data
RUN sed -i -e "s@datadir=.*@datadir=/data@g" /etc/my.cnf.d/mariadb-server.cnf 

COPY ["mariadb/run.sh", "/usr/local/bin/"]
RUN chmod 777 -R /usr/local/bin/ 
ENTRYPOINT ["/usr/local/bin/run.sh"]