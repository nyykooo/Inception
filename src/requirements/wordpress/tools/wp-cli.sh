#!/bin/sh

set -e

# GET SECRETS
DB_USER_PASSWORD=$(cat /run/secrets/db_user_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_ADMIN_EMAIL=$(cat /run/secrets/wp_admin_email)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)
WP_USER_EMAIL=$(cat /run/secrets/wp_user_email)

# echo "Waiting for MariaDb"
# until mysql -h mariadb -u "${MYSQL_USER}" -p "${DB_USER_PASSWORD}" SELECT "1"; do
# echo "MariaDb not ready yet";
# sleep 2;
# done
echo "Waiting for MariaDB to be ready..."
until mysql -h "$DB_HOST" -u "$MYSQL_USER" -p"$DB_USER_PASSWORD" -e "SELECT 1" >/dev/null 2>&1; do
    sleep 1
done
echo "MariaDB is ready!"

# It's important to add --allow root because by default 
# running wp-cli ad root can be dangerous, because if any code is malicious
# or contains a bug, it could potentially compromise the entire server
# as this environment is controlled and safe from this risks, I will use --allow-root
# to give full acess and install the wp properly



cd /var/www/html

# creates a configuration file with the db created by mariadb container
if [ ! -f wp-config.php ]; then
    wp core download --allow-root --force
    echo "wp-config.php does not exist...\ncreating configuration file"
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${DB_USER_PASSWORD}" \
        --dbhost="${DB_HOST}" \
        --locale=en_US \
        --allow-root
else
    echo "wp-config.php exists...\nmaking sure it has the right configs"
    wp config set DB_NAME "${MYSQL_DATABASE}" --allow-root
    wp config set DB_USER "${MYSQL_USER}" --allow-root
    wp config set DB_PASSWORD "${DB_USER_PASSWORD}" --allow-root
    wp config set DB_HOST "${DB_HOST}" --allow-root

fi

if ! wp core is-installed --allow-root; then
    # install wordpress through github repo
    echo installing wordpress through github repo
    wp core install \
        --url="${WP_URL}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --skip-email \
        --allow-root
else
    if wp user get "${WP_ADMIN_USER}" --field=ID --allow-root; then
        echo updating admin user
        wp user update "${WP_ADMIN_USER}" \
            --user_pass="${WP_ADMIN_PASSWORD}" \
            --role=administrator \
            --allow-root || true
    else
        # create a new user
        echo create a new user
        wp user create \
            --user_pass="${WP_ADMIN_PASSWORD}" \
            --role=administrator \
            --allow-root || true
    fi
fi

chown -R www-data:www-data /var/www/html 
chmod -R 755 /var/www/html

exec php-fpm8.2 -F