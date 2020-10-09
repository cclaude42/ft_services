FROM alpine:latest

COPY nginx.conf index.html telegraf.conf setup.sh ./

# Install nginx and dependencies
RUN apk update && \
	apk add --no-cache nginx openssh openssl

# Setup nginx
RUN mkdir -p /run/nginx www && \
	mv nginx.conf /etc/nginx/ && \
	mv index.html /www/

# Setup SSL
RUN openssl req -new -newkey rsa:2048 -nodes -days 365 -x509 \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=Federation/CN=localhost" \
	-keyout /etc/ssl/private/services.key -out /etc/ssl/certs/services.crt

# Setup SSH
RUN ssh-keygen -A && \
	adduser -D ssh_admin && \
	echo "ssh_admin:0101" | chpasswd

# Install telegraf
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ telegraf && \
	mkdir -p /etc/telegraf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 22 80 443

CMD ./setup.sh
