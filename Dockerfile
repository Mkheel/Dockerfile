FROM wordpress:php8.2-apache

RUN docker-php-ext-install mysqli pdo pdo_mysql

# Corrige MPM duplicado
RUN a2dismod mpm_event || true \
 && a2enmod mpm_prefork

# Faz o Apache escutar na porta do Railway
RUN sed -i 's/80/${PORT}/g' /etc/apache2/ports.conf \
 && sed -i 's/:80/:${PORT}/g' /etc/apache2/sites-available/000-default.conf

# Limites de upload pro backup
RUN echo "upload_max_filesize=256M" >> /usr/local/etc/php/conf.d/uploads.ini \
 && echo "post_max_size=256M" >> /usr/local/etc/php/conf.d/uploads.ini \
 && echo "memory_limit=256M" >> /usr/local/etc/php/conf.d/uploads.ini

EXPOSE 8080
