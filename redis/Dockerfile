FROM redis

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
COPY ["redis/redis.conf","/usr/local/etc/redis/"]

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]