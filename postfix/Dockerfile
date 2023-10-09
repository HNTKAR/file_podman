FROM alpine

RUN apk update && \
    apk add postfix tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN echo "postlog unix-dgram n - n - 1 postlogd" >> /etc/postfix/master.cf
RUN echo "maillog_file = /dev/stdout" >> /etc/postfix/main.cf
RUN newaliases

ENTRYPOINT [ "postfix" ]
CMD [ "start-fg" ]