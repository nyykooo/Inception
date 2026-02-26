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
    wget \
    # install mariadb-cli
    mariadb-client \
    # test
    net-tools

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Keep a pristine WordPress copy inside the image.
# We do NOT extract directly into /var/www/wordpress because that path is bind-mounted
# in docker-compose, and an empty host directory would hide image contents.
RUN mkdir -p /usr/src

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /usr/src/ \
    && mv /usr/src/wordpress /usr/src/wordpress-core \
    && rm /tmp/wordpress.tar.gz

# Create runtime web root
RUN mkdir -p /var/www/wordpress

RUN mkdir -p /run/php

# Create runtime web root
RUN mkdir -p /var/www/wordpress

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN set -eux; \
    PHP_VER="$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')"; \
    WWW_CONF="/etc/php/${PHP_VER}/fpm/pool.d/www.conf"; \
    sed -i "s#listen = /run/php/php${PHP_VER}-fpm.sock#listen = 9000#g" "${WWW_CONF}"; \
    sed -i 's/^listen\.allowed_clients\s*=.*/;listen.allowed_clients = 127.0.0.1/' "${WWW_CONF}"

COPY ./tools/wp-cli.sh /usr/local/bin/wp-cli.sh
WORKDIR /var/www/html

RUN chmod +x /usr/local/bin/wp-cli.sh

ENTRYPOINT ["/usr/local/bin/wp-cli.sh"]