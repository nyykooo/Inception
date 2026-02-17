#!/bin/sh

set -e

# GET SECRETS
DB_USER_PASSWORD=$(cat /run/secrets/db_user_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_ADMIN_EMAIL=$(cat /run/secrets/wp_admin_email)
WP_USER_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_EMAIL=$(cat /run/secrets/wp_user_email)

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
    --dbpass=$(DB_USER_PASSWORD) \
    --dbhost=$(DB_HOST) \
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
    --user=$(WP_USER) \
    --email=$(WP_USER_EMAIL) \
    --user_pass=$(WP_USER_PASSWORD) \
    --role=subscriber \
    --allow-root

fi

exec php-fpm