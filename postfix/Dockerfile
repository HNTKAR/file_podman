FROM rockylinux:9

RUN unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime

RUN dnf -y update && \
    dnf -y install postfix

COPY ["postfix/run.sh", "/usr/local/bin/"]

RUN chmod 777 -R /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run.sh"]