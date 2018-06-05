FROM ubuntu:18.04

ENV TERM=xterm

RUN apt-get update && apt-get install -y debconf-utils tzdata

RUN ln -fs /usr/share/zoneinfo/Europe/Madrid /etc/localtime && \
    echo "Europe/Madrid" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y curl unzip wget build-essential libssl-dev git jpegoptim libicu-dev libgd-dev php7.2-fpm
RUN apt-get install -y php7.2-intl php7.2-dev php-pear php7.2-curl php7.2-mongodb php7.2-mbstring php7.2-bcmath php7.2-zip php7.2-xsl php7.2-imap php7.2-bz2 php7.2-mysql

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"
RUN composer global require hirak/prestissimo

RUN pecl install grpc && pecl install protobuf

EXPOSE 9000
CMD ["php-fpm7.2","-F"]

