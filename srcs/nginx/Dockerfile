FROM alpine:latest

# COPY nginx.conf sshd_config index.html setup.sh ./

# Install nginx, SSH and SSL
RUN apk update && \
	apk add --no-cache nginx openssl openssh

CMD yes
