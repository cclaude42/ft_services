FROM alpine:latest

COPY setup.sh ./

# Install MariaDB and dependencies
RUN apk update && \
	apk add --no-cache mysql mysql-client

CMD ./setup.sh
