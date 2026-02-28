FROM wordpress:php8.2-apache

RUN docker-php-ext-install mysqli pdo pdo_mysql

RUN echo "upload_max_filesize=256M" >> /usr/local/etc/php/conf.d/uploads.ini \
 && echo "post_max_size=256M" >> /usr/local/etc/php/conf.d/uploads.ini \
 && echo "memory_limit=256M" >> /usr/local/etc/php/conf.d/uploads.ini
