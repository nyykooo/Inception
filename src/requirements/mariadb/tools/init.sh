#!/bin/bash

MYSQL_DATABASE=mariadb
MYSQL_USER=ncampbel

# The code bellow is included in mariadb image, but as I'm creating my own image,
# I must guarantee that the mariadb is configured before creating a DB in it
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    # creates internal structure and tables
    mysql_install_db --user=mysql
    # Start MariaDB in the background to run setup commands
    # --skip-name-resolve avoids DNS lookups
    # --socket sets the Unix socket path
    mysqld --skip-name-resolve --socket=/var/run/mysqld/mysqld.sock &

    # Wait until MariaDB is ready to accept connections avoiding race conditions
    until mysqladmin --socket=/var/run/mysqld/mysqld.sock ping --silent; do
        sleep 1
    done

  
    mysql --socket=/var/run/mysqld/mysqld.sock -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;

EOF
# - FLUSH PRIVILEGES makes the changes effective immediately

    # Shut down the temporary background MariaDB process
    mysqladmin --socket=/var/run/mysqld/mysqld.sock -u root -p"$DB_ROOT_PASSWORD" shutdown
fi

# Start MariaDB normally
exec mysqld --user=mysql --bind-address=0.0.0.0