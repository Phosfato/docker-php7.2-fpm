FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update -yq && \
    apt-get upgrade -yq && \
    apt-get install -yq \
        php7.2-bcmath \
        # falta o devel será que precisa? depois de instalar o php-dev ele ainda não lista devel
        # RUN apt-get install -qy php-dev
        php7.2-fpm \
        php7.2-gd \
        php7.2-intl \
        php7.2-mbstring \
        php7.2-mysql \
        php7.2-soap \
        php7.2-xml \
        php7.2-curl \
        php7.2-zip && \
    ln -sf /dev/stdout /var/log/php7.2-fpm.log && \
    # remove files left by `apt-get update`
    rm -rf /var/lib/apt/lists/*

COPY php-fpm.conf /etc/php/7.2/fpm/
COPY www.conf /etc/php/7.2/fpm/pool.d/

STOPSIGNAL SIGQUIT

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.2", "--allow-to-run-as-root"]