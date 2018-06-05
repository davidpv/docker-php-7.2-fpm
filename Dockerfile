FROM php:7.2-fpm

#php extensions and commands
RUN apt-get update && apt-get install -y curl unzip wget build-essential libssl-dev git jpegoptim libicu-dev libgd-dev && \
    php7.2-fpm-common php7.2-mongodb php-pear php7.2-dev
RUN pecl install grpc && pecl install protobuf

#composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"