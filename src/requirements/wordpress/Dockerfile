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
    curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

WORKDIR /var/www/html

RUN chmod +x ./tools/wp-cli.sh

EXPOSE 9000

CMD ["./tools/wp-cli.sh"]