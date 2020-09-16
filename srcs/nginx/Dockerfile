FROM alpine:latest

COPY nginx.conf index.html sshd_config setup.sh ./

# Install nginx and dependencies
RUN apk update && \
	apk add --no-cache nginx openssh openssl

# Setup nginx
RUN mkdir -p run/nginx && \
	mv nginx.conf etc/nginx/ && \
	mkdir -p www && \
	mv index.html www/

# Setup SSH and SSL
RUN mv sshd_config etc/ssh/ && \
	openssl req -new -newkey rsa:2048 -nodes -days 365 -x509 \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=Federation/CN=localhost" \
	-keyout etc/ssl/private/services.key -out etc/ssl/certs/services.crt

EXPOSE 22 80 443

CMD ./setup.sh
