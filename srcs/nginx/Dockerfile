FROM alpine:latest

COPY nginx.conf sshd_config index.html setup.sh ./

# Install nginx and dependencies
RUN apk update && \
	apk add --no-cache nginx openssl openssh

# Setup nginx
# RUN mkdir

# Setup SSL and SSH
RUN

EXPOSE 22 80 443

CMD ./setup.sh
