FROM debian:bookworm

RUN apt update && apt upgrade -y && \
apt install -y mariadb-server && \
rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld \
&& chown mysql:mysql /var/run/mysqld \
&& chmod 755 /var/run/mysqld

COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/mariadb.cnf
COPY ./tools/init.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/init.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/init.sh"]