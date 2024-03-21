FROM alpine

ENV TZ='Asia/Tokyo'

RUN apk add --no-cache postfix tzdata

RUN echo "postlog unix-dgram n - n - 1 postlogd" >> /etc/postfix/master.cf
RUN echo "maillog_file = /dev/stdout" >> /etc/postfix/main.cf

ENTRYPOINT [ "postfix" ]
CMD [ "start-fg" ]