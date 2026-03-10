#!/bin/bash

until mysqladmin ping -h mariadb -u $SQL_USER -p$SQL_PASSWORD --silent 2>/dev/null; do
    sleep 2
done

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    wp config create --allow-root \
                    --dbname=$SQL_DATABASE \
                    --dbuser=$SQL_USER \
                    --dbpass=$SQL_PASSWORD \
                    --dbhost=mariadb:3306 \
                    --path='/var/www/wordpress'

    wp core install --allow-root \
                    --url=$DOMAIN_NAME \
                    --title="inception" \
                    --admin_user=$WP_ADMIN \
                    --admin_password=$WP_ADMIN_PASS \
                    --admin_email=$WP_ADMIN_EMAIL \
                    --path='/var/www/wordpress'

    wp user create --allow-root \
                    $WP_USER $WP_USER_EMAIL \
                    --role=author \
                    --user_pass=$WP_USER_PASS \
                    --path='/var/www/wordpress'

fi

exec /usr/sbin/php-fpm7.4 -F