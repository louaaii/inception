FROM debian:bullseye


RUN apt-get update && \
    apt install mariadb-server -y

COPY /conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY /tools/script.sh /

RUN chmod +x /script.sh

ENTRYPOINT  ["/script.sh"]