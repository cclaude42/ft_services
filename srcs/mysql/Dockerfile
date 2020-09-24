FROM alpine:latest

COPY setup.sh ./

# Install MySQL and dependencies
RUN apk update && \
	apk add --no-cache mariadb mariadb-client

CMD ./setup.sh
