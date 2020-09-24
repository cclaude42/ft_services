FROM alpine:latest

COPY setup.sh ./

# Install MariaDB and dependencies
RUN apk update && \
	apk add --no-cache mariadb mariadb-client

# Configure MariaDB
RUN sed -i 's/skip-/#skip-/' /etc/my.cnf.d/mariadb-server.cnf

CMD ./setup.sh
