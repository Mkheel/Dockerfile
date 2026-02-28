FROM wordpress:6.4.3-php8.2-apache

# remove qualquer MPM extra e força prefork
RUN a2dismod mpm_event mpm_worker || true \
 && a2enmod mpm_prefork

# extensões do MySQL
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Apache escutar na porta do Railway
ENV APACHE_LISTEN_PORT=8080
RUN sed -i 's/80/${APACHE_LISTEN_PORT}/g' /etc/apache2/ports.conf \
 && sed -i 's/:80/:${APACHE_LISTEN_PORT}/g' /etc/apache2/sites-available/000-default.conf

EXPOSE 8080

# limite de upload pro backup
RUN echo "upload_max_filesize=256M" > /usr/local/etc/php/conf.d/uploads.ini \
 && echo "post_max_size=256M" >> /usr/local/etc/php/conf.d/uploads.ini \
 && echo "memory_limit=256M" >> /usr/local/etc/php/conf.d/uploads.ini
