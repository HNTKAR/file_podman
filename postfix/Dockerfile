FROM rockylinux:9

RUN unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime

RUN dnf -y update && \
    dnf -y install postfix
RUN sed -i "\$a maillog_file = /dev/stdout" /etc/postfix/main.cf

COPY ["postfix/run.sh", "/usr/local/bin/"]

RUN chmod 777 -R /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run.sh"]