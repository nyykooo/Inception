FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y php \
    # php fastcgi process manager
    php-fpm \
    # allows php to talk to DB
    php-mysql \
    # Image manipulation library
    php-gd \
    # Http requests
    php-curl \
    # XML parser
    php-xml \
    # multibyte string handling (UTF-8, unicode, ...)
    php-mbstring \
    # read/write zip archives
    php-zip \
    # internationalization via ICU (International Components for Unicode)
    php-intl \
    # reads EXIF (Exchangeable Image File Format) metadata from images
    php-exif \
    # install curl to get wp-cli
    curl \
    # install netcat to check mariadb container
    netcat-openbsd

RUN mkdir -p /run/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./tools/wp-cli.sh /usr/local/bin/wp-cli.sh
WORKDIR /var/www/html

RUN chmod +x /usr/local/bin/wp-cli.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wp-cli.sh"]
# CMD ["php-fpm8.2", "-F"]