FROM debian:bullseye

RUN apt-get update && \
    apt-get -y install wget && \
    apt-get install -y php7.4 \
            php-fpm \
            php-mysql \
            mariadb-client 

RUN mkdir -p /run/php
    
RUN wget https://wordpress.org/wordpress-6.9.tar.gz -P /var/www

RUN cd  /var/www && \
        tar -xvf /var/www/wordpress-6.9.tar.gz && \
        rm /var/www/wordpress-6.9.tar.gz

RUN chown -R root:root /var/www/wordpress

COPY /conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY /tools/config.sh /
RUN chmod +x /config.sh

ENTRYPOINT ["/config.sh"]