FROM php:8.2-fpm

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
COPY ["php/php-fpm.conf","${PHP_INI_DIR}-fpm.d/zzz-php-fpm.conf"]
COPY ["php/user.ini","${PHP_INI_DIR}/conf.d/"]
COPY ["php/config.php.txt","/usr/local/src/"]
COPY ["php/docker-run","/usr/local/bin/"]

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
RUN ln -s /var/www/nextcloud/occ /usr/local/bin/occ && \
    chmod 775 /usr/local/bin/docker-run 

COPY ["php/user-ext.ini","${PHP_INI_DIR}/conf.d/"]
WORKDIR /var/www

CMD [ "docker-run" ]