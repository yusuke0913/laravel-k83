FROM php:7.2-fpm-alpine

RUN apk update
RUN docker-php-ext-install pdo pdo_mysql opcache mbstring

CMD ["php-fpm"]
