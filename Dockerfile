FROM php:8.2

# Install required packages
RUN apt-get update -y && apt-get install -y \
    openssl \
    zip \
    unzip \
    git \
    libssl-dev \
    libzip-dev \
    libonig-dev \
    libpq-dev \
    && docker-php-ext-install pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app
COPY composer.json composer.json
#COPY composer.lock composer.lock
COPY . .
RUN composer install 
RUN composer dump-autoload

EXPOSE 8000
CMD php artisan serve --host=0.0.0.0 --port=8000