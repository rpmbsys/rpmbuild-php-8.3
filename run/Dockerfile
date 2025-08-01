ARG rocky=10.0.20250606
ARG image=web
FROM ghcr.io/aursu/rockylinux:${rocky}-${image}

LABEL org.opencontainers.image.source=https://github.com/rpmbsys/rpmbuild-php-8.3

COPY system/etc/yum.repos.d/bintray-custom-rocky.repo /etc/yum.repos.d/bintray-custom.repo

RUN microdnf -y --enablerepo=crb --enablerepo=bintray-custom --enablerepo=bintray-phpcustom install \
        ImageMagick-libs \
        php-bcmath-8.3.23 \
        php-cli-8.3.23 \
        php-fpm-8.3.23 \
        php-opcache-8.3.23 \
        php-pecl-apcu \
        php-pecl-geoip \
        php-pecl-memcached \
        php-pecl-redis6 \
        php-sodium-8.3.23 \
        php-xml-8.3.23 \
        tzdata \
    && microdnf -y --disablerepo=epel --enablerepo=bintray-phpcustom install \
        php-pecl-imagick \
    && microdnf clean all && rm -rf /var/cache/dnf /var/lib/rpm/__db*

# php-fpm configuration
COPY system/etc/php-fpm.conf /etc/php-fpm.conf
COPY system/etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf
COPY system/etc/php.ini /etc/php.ini

ENV PHP_FPM_USER=www-data \
    PHP_FPM_GROUP=www-data \
    PHP_FPM_LISTEN=9000 \
    PHP_FPM_PM_STYLE=dynamic \
    PHP_FPM_PM_MAX_CHILDREN=800 \
    PHP_FPM_PM_START_SERVERS=5 \
    PHP_FPM_PM_MIN_SPARE_SERVERS=5 \
    PHP_FPM_PM_MAX_SPARE_SERVERS=35 \
    PHP_FPM_PM_MAX_REQUESTS=500 \
    PHP_FPM_PM_STATUS_PATH=""

ENV PHP_INI_SHORT_OPEN_TAG=On \
    PHP_INI_OUTPUT_BUFFERING=Off \
    PHP_INI_DISABLE_FUNCTIONS="" \
    PHP_INI_DISABLE_CLASSES="" \
    PHP_INI_EXPOSE_PHP=Off \
    PHP_INI_MAX_INPUT_TIME=-1 \
    PHP_INI_LOG_ERRORS=Off \
    PHP_INI_ERROR_LOG="" \
    PHP_INI_ERROR_REPORTING="E_ALL & ~E_DEPRECATED & ~E_STRICT" \
    PHP_INI_SESSION_USE_COOKIES=1 \
    PHP_INI_SESSION_NAME=PHPSESSID \
    PHP_INI_SESSION_UPLOAD_PROGRESS_ENABLED=On \
    PHP_INI_SESSION_UPLOAD_PROGRESS_NAME=PHP_SESSION_UPLOAD_PROGRESS \
    PHP_INI_POST_MAX_SIZE=8M \
    PHP_INI_UPLOAD_MAX_FILESIZE=2M \
    PHP_INI_FILE_UPLOADS=On \
    PHP_INI_ALLOW_URL_FOPEN=On \
    PHP_INI_MEMORY_LIMIT=128M \
    PHP_INI_DISPLAY_ERRORS=Off \
    PHP_INI_DISPLAY_STARTUP_ERRORS=Off \
    PHP_INI_LOG_ERRORS_MAX_LEN=8192 \
    PHP_INI_DATE_TIMEZONE=Europe/Berlin \
    PHP_INI_SESSION_COOKIE_HTTPONLY="" \
    PHP_INI_SESSION_GC_MAXLIFETIME=1440 \
    PHP_INI_MAX_EXECUTION_TIME=30


WORKDIR /var/www/html
EXPOSE ${PHP_FPM_LISTEN}
CMD [ "/usr/sbin/php-fpm", "--nodaemonize" ]
