FROM rockylinux:9

# ARG CONFIG_FILE="nginx.conf"

# ENV PATH=$PATH:/opt/remi/php82/root/bin
RUN dnf -y update && \
    # dnf -y install php
    dnf -y install epel-release && \
    dnf -y upgrade && \
    dnf -y install https://rpms.remirepo.net/enterprise/remi-release-9.rpm && \
    dnf -y --enablerepo=remi upgrade && \
    dnf -y --enablerepo=remi install php81 &&\
    dnf -y --enablerepo=remi install -y php81-php-{fpm,ctype,curl,dom,fileinfo,filter,gd,hash,json,libxml,mbstring,openssl,posix,session,simplexml,xmlreader,xmlwriter,zip,zlib,pdo_sqlite,pdo_mysql,pdo_pgsql,bz2,intl,ldap,smbclient,ftp,imap,bcmath,gmp,exif,apcu,memcached,redis,imagick,pcntl,phar}

# /etc/opt/remi/php82/php.ini
# ADD ["${CONFIG_FILE}","/etc/nginx/conf_user.d/"]
# RUN sed -i -e "s/listen =.*/listen = localhost:9000/g" /etc/opt/remi/php82/php-fpm.d/www.conf
RUN sed -i -e "s/;access.log =.*/;access.log = log\/\$pool.access.log/g" /etc/opt/remi/php81/php-fpm.d/www.conf
RUN sed -i -e "s/group =.*/group = root/g" /etc/opt/remi/php81/php-fpm.d/www.conf
RUN sed -i -e "s/user =.*/user = root/g" /etc/opt/remi/php81/php-fpm.d/www.conf
COPY ["php/run.sh", "/usr/local/bin/"]

# RUN sed -i -e "s/listen =.*/listen = 172.0.0.1:9000/g" /etc/opt/remi/php82/php-fpm.d/www.conf
RUN chmod 777 -R /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run.sh"]