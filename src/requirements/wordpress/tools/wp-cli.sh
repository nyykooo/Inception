#!/bin/sh

set -e

cd /var/www/html

# verify/test if wp-config.php file exists
# if not, create it, else just run php-fpm
if [ ! -f wp-config.php ]; then

# It's important to add --allow root because by default 
# running wp-cli ad root can be dangerous, because if any code is malicious
# or contains a bug, it could potentially compromise the entire server
# as this environment is controlled and safe from this risks, I will use --allow-root
# to give full acess and install the wp properly
wp core download --allow-root

# creates a configuration file with the db created by mariadb container
wp config create \
    --dbname=$(MYSQL_DATABASE) \
    --dbuser=$(MYSQL_USER) \
    --dbpass=$(MYSQL_PASSWORD) \
    --dbhost=$(MYSQL_HOST) \
    --locale=en_US \
    --allow-root

# install wordpress through github repo
wp core install \
    --url=$(WP_URL) \
    --title=$(WP_TITLE) \
    --admin_user=$(WP_ADMIN_USER) \
    --admin_password=$(WP_ADMIN_PASSWORD) \
    --admin_email=$(WP_ADMIN_EMAIL) \
    --skip-email \
    --allow-root

# create a new user
wp user create \
    $(WP_USER) \
    $(WP_USER_EMAIL) \
    --user_pass=$(WP_USER_PASSWORD) \
    --role=subscriber \
    --allow-root

fi

exec php-fpm