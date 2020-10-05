FROM alpine:latest

COPY setup.sh ./

# Install PHP
RUN apk update && \
	apk add --no-cache php7 php7-fpm php7-opcache php7-gd php7-mysqli \
	php7-zlib php7-curl php7-mbstring php7-json php7-session

# Download PHPMyAdmin
ADD https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz .

# Install PHPMyAdmin
RUN tar -xvf phpMyAdmin-5.0.2-english.tar.gz && \
	mv phpMyAdmin-5.0.2-english /www && \
	rm -f phpMyAdmin-5.0.2-english.tar.gz

EXPOSE 5000

CMD ./setup.sh
