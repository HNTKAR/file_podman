FROM nginx:mainline

ENV TZ='Asia/Tokyo'

RUN apt -y update &&\
        apt -y upgrade

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime

COPY ["nginx/sites/*", "/usr/local/share/"]

COPY ["nginx/config/*", "/usr/local/lib/conf/"]
RUN mv /usr/local/lib/conf/nginx-user.conf /etc/nginx/nginx-user.conf

COPY ["nginx/run.sh", "/usr/local/bin/"]
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/run.sh"]
