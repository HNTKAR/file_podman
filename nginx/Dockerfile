FROM nginx:mainline

ARG P12_PASS="password"
ENV TZ='Asia/Tokyo'
ENV CERT_DIR="/usr/local/share/mtls"

RUN apt -y update &&\
        apt -y upgrade

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime

RUN groupadd samba &&\
        usermod -aG samba nginx

RUN mkdir -p /usr/local/share/mtls
# CA証明書を作成
RUN openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout ${CERT_DIR}/ca.key -noenc -out ${CERT_DIR}/ca.crt -subj="/C=JP/CN=CA"

# サーバー証明書を作成
RUN openssl req -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout ${CERT_DIR}/server.key -noenc -out ${CERT_DIR}/server.csr -subj "/C=JP/CN=server" &&\
        openssl x509 -req -CA ${CERT_DIR}/ca.crt -CAkey ${CERT_DIR}/ca.key -in ${CERT_DIR}/server.csr -out ${CERT_DIR}/server.crt

# クライアント証明書を作成
RUN openssl req -noenc -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout ${CERT_DIR}/client.key -out ${CERT_DIR}/client.csr -subj "/C=JP/CN=client" &&\
        openssl x509 -req -CA ${CERT_DIR}/ca.crt -CAkey ${CERT_DIR}/ca.key -in ${CERT_DIR}/client.csr -out ${CERT_DIR}/client.crt &&\
        openssl pkcs12 -export -inkey ${CERT_DIR}/client.key -in ${CERT_DIR}/client.crt -certfile ${CERT_DIR}/ca.crt -out ${CERT_DIR}/client.p12 -passout pass:"${P12_PASS}"

COPY ["nginx/config/mime-append.types", "/etc/nginx/mime-append.types"]

COPY ["nginx/config/*.conf", "/usr/local/lib/conf/"]
RUN mv /usr/local/lib/conf/nginx-user.conf /etc/nginx/nginx-user.conf

COPY ["nginx/sites", "/usr/local/share/sites/"]

COPY ["nginx/run.sh","nginx/certmgr", "/usr/local/bin/"]
RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/run.sh"]
