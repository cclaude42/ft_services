FROM alpine:latest

COPY telegraf.conf setup.sh ./

# Install influxdb and dependencies
RUN apk update && \
	apk add --no-cache influxdb

# Install telegraf
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ telegraf && \
	mkdir -p /etc/telegraf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 8086

CMD ./setup.sh
