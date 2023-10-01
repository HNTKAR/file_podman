FROM redis
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
COPY ["redis/redis.conf","/usr/local/etc/redis/"]
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]

# FROM rockylinux:9

# RUN unlink /etc/localtime && \
#     ln -s /usr/share/zoneinfo/Japan /etc/localtime

# RUN dnf -y update && \
#     dnf -y install redis

# RUN mkdir /sock
# RUN sed -i.old -e "s/# unixsocket/unixsocket/g" \
#     -e "s@/run/redis.sock@/sock/redis.sock@g" \
#     -e "s/port.*/port 0/g" /etc/redis/redis.conf

# COPY ["redis/run.sh", "/usr/local/bin/"]

# RUN chmod 777 -R /usr/local/bin/
# ENTRYPOINT ["/usr/local/bin/run.sh"]