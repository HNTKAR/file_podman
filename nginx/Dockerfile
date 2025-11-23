FROM nginx:mainline

ENV TZ='Asia/Tokyo'

RUN apt -y update &&\
        apt -y upgrade

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime

RUN groupadd samba &&\
        usermod -aG samba nginx

RUN mkdir -p /etc/nginx/mtls
# CA証明書を作成
RUN openssl req -x509 -newkey rsa:2048 -keyout /etc/nginx/mtls/ca.key -noenc -out /etc/nginx/mtls/ca.crt -subj="/C=JP/CN=CA/O=local CA"
# RUN openssl req -x509 -newkey Ed25519 -keyout /etc/nginx/mtls/ca.key -noenc -out /etc/nginx/mtls/ca.crt -subj="/C=JP/CN=CA/O=local CA"

# サーバー証明書を作成
COPY ["nginx/config/extfile.ini", "/etc/nginx/mtls/"]
RUN openssl req -noenc -newkey rsa:2048 -keyout /etc/nginx/mtls/server.key -out /etc/nginx/mtls/server.csr -subj "/C=JP/CN=server" &&\
        openssl x509 -req -extfile /etc/nginx/mtls/extfile.ini -extensions v3_req -CA /etc/nginx/mtls/ca.crt -CAkey /etc/nginx/mtls/ca.key -in /etc/nginx/mtls/server.csr -out /etc/nginx/mtls/server.crt

# クライアント証明書を作成
RUN openssl req -noenc -newkey rsa:2048 -keyout /etc/nginx/mtls/client.key -out /etc/nginx/mtls/client.csr -subj "/C=JP/CN=user" &&\
        openssl x509 -req -CA /etc/nginx/mtls/ca.crt -CAkey /etc/nginx/mtls/ca.key -in /etc/nginx/mtls/client.csr -out /etc/nginx/mtls/client.crt &&\
        openssl pkcs12 -export -inkey /etc/nginx/mtls/client.key -in /etc/nginx/mtls/client.crt -certfile /etc/nginx/mtls/ca.crt -name "user" -out /etc/nginx/mtls/user.p12 -passout pass:"password"

COPY ["nginx/config/mime-append.types", "/etc/nginx/mime-append.types"]

COPY ["nginx/config/*.conf", "/usr/local/lib/conf/"]
RUN mv /usr/local/lib/conf/nginx-user.conf /etc/nginx/nginx-user.conf

COPY ["nginx/sites", "/usr/local/share/sites/"]

COPY ["nginx/run.sh", "/usr/local/bin/"]
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/run.sh"]
