FROM alpine:latest

COPY setup.sh my.cnf init_file ./

# Install MySQL and dependencies
RUN apk update && \
	apk add --no-cache mysql mysql-client

# Setup MySQL
RUN mkdir -p /run/mysqld && \
	mv my.cnf /etc/

EXPOSE 3306

CMD ./setup.sh
