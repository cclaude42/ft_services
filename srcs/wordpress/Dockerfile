# Base OS
FROM alpine:latest

# Install PHP
RUN apk update && \
	apk add --no-cache php7 php7-fpm php7-opcache php7-gd php7-mysqli \
	php7-zlib php7-curl php7-mbstring php7-json php7-session

# Download Wordpress
ADD https://wordpress.org/latest.tar.gz .

# Install Wordpress
RUN mkdir -p /www && \
	tar -xvf latest.tar.gz && \
	mv wordpress/ www/ && \
	rm -f latest.tar.gz

# Copy files
COPY ./wp-config.php /www/wp-config.php
COPY ./setup.sh .

EXPOSE 5050

# Launch script
CMD ./setup.sh
