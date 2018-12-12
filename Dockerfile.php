FROM php:7.2-fpm-alpine

RUN apk update
RUN docker-php-ext-install pdo pdo_mysql opcache mbstring

COPY ./docker.php/zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
COPY ./proj /var/www/html

CMD ["php-fpm"]
