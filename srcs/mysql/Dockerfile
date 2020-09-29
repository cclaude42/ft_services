FROM alpine:latest

COPY setup.sh my.cnf mysql_init ./

# Install MySQL and dependencies
RUN apk update && \
	apk add --no-cache mysql mysql-client

EXPOSE 3306

CMD ./setup.sh
