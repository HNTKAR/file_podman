FROM php:8.2-fpm

# VOLUME [ "/usr/local" ]

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
COPY ["php/php-fpm.conf","${PHP_INI_DIR}-fpm.d/zzz-php-fpm.conf"]
COPY ["php/user.ini","${PHP_INI_DIR}/conf.d/"]

RUN apt -y update && \
    apt -y install \
        ffmpeg \
        libzip-dev \
        libpng-dev \
        libbz2-dev \
        libicu-dev \
        libc-client-dev \
        libgmp-dev \
        libsmbclient-dev \
        libmagickwand-dev \
        libkrb5-dev && \
    apt clean
RUN pecl install smbclient apcu redis imagick && \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-configure gd --with-freetype && \
    docker-php-ext-install -j$(nproc) zip gd pdo_mysql bz2 intl imap bcmath gmp exif pcntl sysvsem opcache
COPY ["php/user-ext.ini","${PHP_INI_DIR}/conf.d/"]
WORKDIR /var/www
CMD [ "--allow-to-run-as-root" ]

# FROM rockylinux:9

# ARG PHP_VER=82
# ENV PHP_VER=${PHP_VER}

# RUN unlink /etc/localtime && \
#     ln -s /usr/share/zoneinfo/Japan /etc/localtime

# # ENV PATH=$PATH:/opt/remi/php82/root/bin
# RUN dnf -y update && \
#     dnf -y install epel-release && \
#     dnf -y install https://rpms.remirepo.net/enterprise/remi-release-9.rpm && \
#     dnf -y install cronie php${PHP_VER} php${PHP_VER}-php-{pecl-apcu,ctype,curl,dom,fileinfo,filter,gd,hash,json,libxml,mbstring,openssl,posix,session,simplexml,xmlreader,xmlwriter,zip,zlib,pdo_sqlite,pdo_mysql,pdo_pgsql,bz2,intl,ldap,smbclient,ftp,imap,bcmath,gmp,exif,apcu,memcached,redis,imagick,pcntl,phar}

# RUN mkdir /sock
# RUN sed -i.old -e "s@;access.log =.*@;access.log = log/\$pool.access.log@g" \
#     -e "s/;env/env/g" \
#     -e "s/group =.*/group = root/g" \
#     -e "s/user =.*/user = root/g" \
#     -e "s@listen =.*@listen = /sock/www.sock@g" /etc/opt/remi/php${PHP_VER}/php-fpm.d/www.conf
# RUN sed -i.old -e "s@pdo_mysql.default_socket=@pdo_mysql.default_socket = /sock/mysql.sock@g" \
#     -e "s/memory_limit =.*/memory_limit =512M/g" /etc/opt/remi/php${PHP_VER}/php.ini
# RUN sed -i.old -e "s/interned_strings_buffer.*/interned_strings_buffer=32/g" \
#     -e "/interned_strings_buffer/ s/^;//g" /etc/opt/remi/php${PHP_VER}/php.d/10-opcache.ini 
# RUN echo "*/5 * * * * php${PHP_VER} /var/www/nextcloud/cron.php" |crontab -
# # RUN echo "[apcu]" >> /etc/opt/remi/php${PHP_VER}/php.ini
# # RUN echo "apc.enable_cli = 1" >> /etc/opt/remi/php${PHP_VER}/php.ini
# # RUN echo "apc.ttl=7200" >> /etc/opt/remi/php${PHP_VER}/php.ini
# # RUN echo "apc.shm_size=32M" >> /etc/opt/remi/php${PHP_VER}/php.ini
# # # RUN echo "apc.serializer=php81" >> /etc/opt/remi/php${PHP_VER}/php.ini
# COPY ["php/run.sh", "/usr/local/bin/"]

# RUN chmod 777 -R /usr/local/bin/
# ENTRYPOINT ["/usr/local/bin/run.sh"]