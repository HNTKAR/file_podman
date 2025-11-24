FROM nginx:mainline

ARG P12_PASS="password"
ENV TZ='Asia/Tokyo'
ENV CERT_DIR="/usr/local/share/mtls"

RUN apt -y update &&\
        apt -y upgrade

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime

RUN groupadd samba &&\
        usermod -aG samba nginx

COPY ["nginx/config/mime-append.types", "/etc/nginx/mime-append.types"]

COPY ["nginx/config/*.conf", "/usr/local/lib/conf/"]
RUN mv /usr/local/lib/conf/nginx-user.conf /etc/nginx/nginx-user.conf

COPY ["nginx/sites", "/usr/local/share/sites/"]

COPY ["nginx/run.sh","nginx/certmgr", "/usr/local/bin/"]
RUN chmod +x /usr/local/bin/*

COPY ["nginx/config/openssl-append.ini", "/usr/lib/openssl.cnf"]

RUN cat /usr/lib/openssl.cnf >> /usr/lib/ssl/openssl.cnf

RUN mkdir -p ${CERT_DIR}

# CA証明書を作成
RUN openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout ${CERT_DIR}/ca.key -noenc -out ${CERT_DIR}/ca.crt -subj="/CN=CA"

# サーバー証明書を作成
RUN certmgr create -p ${P12_PASS} -c ${CERT_DIR} -o ${CERT_DIR} -s "/C=JP/ST=City/O=Org/CN=server" -d 365 -n "server"


# クライアント証明書を作成
RUN certmgr create -p ${P12_PASS} -c ${CERT_DIR} -o ${CERT_DIR} -s "/C=JP/ST=City/O=Org/CN=client" -d 365 -n "client"

# CRLを作成
WORKDIR ${CERT_DIR}
RUN openssl ca -gencrl -keyfile ${CERT_DIR}/ca.key -cert ${CERT_DIR}/ca.crt -out ${CERT_DIR}/crl.pem

WORKDIR /
ENTRYPOINT ["/usr/local/bin/run.sh"]
