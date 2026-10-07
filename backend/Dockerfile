FROM php:8.3-apache
RUN docker-php-ext-install pdo_mysql
COPY apache.conf /etc/apache2/conf-available/shopkart.conf
RUN a2enconf shopkart
COPY src/ /var/www/html/
