FROM wordpress:php8.2-apache

RUN docker-php-ext-install mysqli pdo pdo_mysql

# Força o Apache a usar apenas prefork (evita erro de MPM duplicado)
RUN a2dismod mpm_event || true \
 && a2enmod mpm_prefork

# Aumenta limite de upload para o backup
RUN echo "upload_max_filesize=256M" >> /usr/local/etc/php/conf.d/uploads.ini \
 && echo "post_max_size=256M" >> /usr/local/etc/php/conf.d/uploads.ini \
 && echo "memory_limit=256M" >> /usr/local/etc/php/conf.d/uploads.ini
