FROM ubuntu:20.04


# Add ondrej/php repository
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y php7.2-bcmath php7.2-imagick php7.2-redis

# Install PHP and nginx dependencies
RUN apt-get update && \
    apt-get install -y \
    nginx \
    php7.2 \
    php7.2-fpm \
    php7.2-mysql \
    php7.2-gd \
    php7.2-xml \
    php7.2-zip \
    php7.2-mbstring \
    php7.2-curl \
    php7.2-intl \
    php7.2-bcmath \
    php7.2-ldap \
    php7.2-gmp \
    php7.2-soap \
    php7.2-imagick \
    php7.2-redis \
    php7.2-xmlrpc \
    php7.2-tidy \
    php7.2-bz2 \
    php7.2-readline \
    php7.2-pspell \
    php7.2-sqlite3 \
    php7.2-odbc \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    libwebp-dev \
    libxpm-dev \
    libzip-dev \
    unzip \
    git \
    curl \
    nano \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add ondrej/php repository
RUN apt-get update && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY default /etc/nginx/sites-available/default

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Start services
CMD service php7.2-fpm start && nginx

EXPOSE 80

ADD app /var/www/html

RUN chmod -R 777 /var/www/html 

