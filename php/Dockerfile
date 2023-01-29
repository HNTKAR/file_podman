FROM rockylinux:9

ARG PHP_VER=81
ENV PHP_VER=${PHP_VER}

RUN unlink /etc/localtime && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime

# ENV PATH=$PATH:/opt/remi/php82/root/bin
RUN dnf -y update && \
    dnf -y install epel-release && \
    dnf -y install https://rpms.remirepo.net/enterprise/remi-release-9.rpm && \
    dnf -y install php${PHP_VER} php${PHP_VER}-php-{ctype,curl,dom,fileinfo,filter,gd,hash,json,libxml,mbstring,openssl,posix,session,simplexml,xmlreader,xmlwriter,zip,zlib,pdo_sqlite,pdo_mysql,pdo_pgsql,bz2,intl,ldap,smbclient,ftp,imap,bcmath,gmp,exif,apcu,memcached,redis,imagick,pcntl,phar}

# /etc/opt/remi/php82/php.ini
# ADD ["${CONFIG_FILE}","/etc/nginx/conf_user.d/"]
# RUN sed -i -e "s/listen =.*/listen = localhost:9000/g" /etc/opt/remi/php82/php-fpm.d/www.conf
RUN sed -i -e "s/;access.log =.*/;access.log = log\/\$pool.access.log/g" \
    -e "s/group =.*/group = root/g" \
    -e "s/user =.*/user = root/g" \
    -e "s/listen =.*/listen = \/run\/php\/www.sock/g" /etc/opt/remi/php${PHP_VER}/php-fpm.d/www.conf
COPY ["php/run.sh", "/usr/local/bin/"]

RUN chmod 777 -R /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run.sh"]