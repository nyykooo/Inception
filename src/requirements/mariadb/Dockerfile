FROM debian:bookworm

EXPOSE 3306

RUN apt-get update && \
    apt-get install -y mariadb-server

RUN mkdir -p /var/run/mysqld \
 && chown mysql:mysql /var/run/mysqld \
 && chmod 755 /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/init.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/init.sh

CMD ["/usr/local/bin/init.sh"]