FROM php:8.3-fpm

ENV TZ='Asia/Tokyo'

RUN apt update && \
    apt install -y \
    # ffmpeg \
    # libreoffice\
    git \
    sudo \
    libzip-dev \
    libpng-dev \
    libicu-dev \
    libgmp-dev \
    libssl-dev \
    libkrb5-dev \
    libsmbclient-dev \
    libmemcached-dev \
    libmagickwand-dev \
    libc-client2007e-dev && \
    apt clean

RUN docker-php-ext-configure gd --with-freetype && \
    docker-php-ext-install -j$(nproc) gd zip pdo_mysql intl ftp bcmath gmp exif pcntl && \
    docker-php-ext-install -j$(nproc) opcache sysvsem

# https://qiita.com/imaiworks/items/7bbbd0a06507c383fa4b
# https://github.com/Imagick/imagick
RUN git clone https://github.com/Imagick/imagick && \
    cd imagick && \
    phpize && \
    ./configure && \
    make && \
    make install

RUN pecl install smbclient apcu redis memcached imap && \
    docker-php-ext-enable smbclient apcu redis memcached imap imagick

COPY ["php-fpm.conf","${PHP_INI_DIR}-fpm.d/zzz-php-fpm.conf"]
COPY ["user.ini","${PHP_INI_DIR}/conf.d/"]
COPY ["init","/usr/local/bin/"]
RUN chmod 777 /usr/local/bin/init

WORKDIR /var/www