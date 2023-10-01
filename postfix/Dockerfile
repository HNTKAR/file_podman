FROM alpine

RUN apk update && \
    apk add postfix tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN echo "postlog unix-dgram n - n - 1 postlogd" >> /etc/postfix/master.cf
RUN echo "maillog_file = /dev/stdout" >> /etc/postfix/main.cf
RUN newaliases

ENTRYPOINT [ "postfix" ]
CMD [ "start-fg" ]

# FROM rockylinux:9

# RUN unlink /etc/localtime && \
#     ln -s /usr/share/zoneinfo/Japan /etc/localtime

# RUN dnf -y update && \
#     dnf -y install postfix
# RUN sed -i -e "\$a maillog_file = /dev/stdout" \
#     -e "s/smtp_tls_security_level.*/smtp_tls_security_level = none/g" \
#     -e "s/smtpd_tls_security_level.*/smtpd_tls_security_level = none/g" /etc/postfix/main.cf

# COPY ["postfix/run.sh", "/usr/local/bin/"]

# RUN chmod 777 -R /usr/local/bin/
# ENTRYPOINT ["/usr/local/bin/run.sh"]