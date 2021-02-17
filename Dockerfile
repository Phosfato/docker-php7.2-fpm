FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -yq && \
    apt-get upgrade -yq && \
    apt-get install -yq \
        php7.2-bcmath \
        php7.2-common \
        php7.2-cli \
        php7.2-curl \
        php7.2-fpm \
        php7.2-gd \
        php7.2-intl \
        php7.2-json \
        php7.2-mbstring \
        php7.2-mysql \
        php7.2-opcache \
        php7.2-readline \
        php7.2-soap \
        php7.2-xml \
        php7.2-zip \
        php-common \
        php-igbinary \
        php-imagick \
        php-memcached \
        php-msgpack \
        php-xdebug \
        php-imagick \
        && \
    ln -sf /dev/stdout /var/log/php7.2-fpm.log && \
    # remove files left by `apt-get update`
    rm -rf /var/lib/apt/lists/*

COPY php-fpm.conf /etc/php/7.2/fpm/
COPY www.conf /etc/php/7.2/fpm/pool.d/

STOPSIGNAL SIGQUIT

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.2", "--allow-to-run-as-root"]