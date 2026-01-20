FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y mariadb-server

RUN mkdir -p /var/run/mysqld \
 && chown mysql:mysql /var/run/mysqld \
 && chmod 755 /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf



CMD ["/usr/local/bin/entrypoint.sh"]