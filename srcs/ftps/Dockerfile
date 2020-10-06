FROM alpine:latest

COPY vsftpd.conf setup.sh ./

# Install vsftpd and dependencies
RUN apk update && \
	apk add --no-cache vsftpd openssl

# Setup vsftpd
RUN mkdir etc/ftps/ftp_user && \
	adduser -D --home=/etc/ftps/ftp_user && \
	echo "ftp_user:0110" | chpasswd && \
	echo "ftp_user" >> /etc/vsftpd/vsftpd.userlist && \
	mv vsftpd.conf /etc/vsftpd/

# Setup SSL
RUN openssl req -new -newkey rsa:2048 -nodes -days 365 -x509 \
	-subj "/C=FR/ST=IDF/L=Paris/O=42/OU=Federation/CN=localhost" \
	-keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

EXPOSE 20 21 21009-21011

CMD ./setup.sh
