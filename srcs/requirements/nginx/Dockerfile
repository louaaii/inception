FROM debian:bullseye


#installation ngnin openssl
RUN apt-get update && \
    apt install nginx openssl -y && \
    apt install curl -y 


#installation de SSL /certificat
RUN openssl req \
            -x509 \
            -nodes \
            -out /etc/ssl/certs/inception.crt \
            -keyout /etc/ssl/private/inception.key \
            -subj "/C=FR/ST=IDF/L=PARIS/O=42/OU=42/CN=LMOKHTAR/UID=LM"
    
#config nginx
RUN mkdir -p /var/run/nginx


COPY conf/nginx.conf /etc/nginx/sites-available/default

RUN chmod 755 /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress


ENTRYPOINT ["nginx", "-g", "daemon off;"]