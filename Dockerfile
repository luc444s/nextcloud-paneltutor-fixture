FROM nextcloud:35-apache

RUN sed -ri 's!Listen 80!Listen 8080!g' /etc/apache2/ports.conf \
    && sed -ri 's!<VirtualHost \*:80>!<VirtualHost *:8080>!g' /etc/apache2/sites-available/000-default.conf \
    && sed -ri '/^: \$\{APACHE_(PID_FILE|RUN_DIR|LOCK_DIR):=/d' /etc/apache2/envvars \
    && printf '%s\n' \
        'APACHE_PID_FILE=/tmp/apache2.pid' \
        'APACHE_RUN_DIR=/tmp' \
        'APACHE_LOCK_DIR=/tmp' \
        'export APACHE_PID_FILE APACHE_RUN_DIR APACHE_LOCK_DIR' \
        >> /etc/apache2/envvars \
    && sed -ri 's!/usr/local/etc/php/conf.d/redis-session.ini!/tmp/redis-session.ini!g' /entrypoint.sh

ENV PHP_INI_SCAN_DIR=/usr/local/etc/php/conf.d:/tmp

USER 33:33
EXPOSE 8080
