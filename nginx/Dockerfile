FROM nginx:mainline

ENV TZ='Asia/Tokyo'

RUN apt -y update &&\
        apt -y upgrade

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime

COPY ["nginx/config/*", "/usr/local/lib/conf/"]
RUN mv /usr/local/lib/conf/nginx-user.conf /etc/nginx/nginx-user.conf

COPY ["nginx/run.sh", "/usr/local/bin/"]
RUN chmod +x /usr/local/bin/*

RUN mkdir -p /usr/local/share/web/ &&\
        chmod 777 -R /usr/local/share/web/ &&\
        echo "<html><body><h1>It works!</h1></body></html>" > /usr/local/share/web/index.html

ENTRYPOINT ["/usr/local/bin/run.sh"]
