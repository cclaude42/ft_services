FROM alpine:latest

COPY setup.sh ./

# Install influxdb and dependencies
RUN apk update && \
	apk add --no-cache influxdb

EXPOSE 8086

CMD ./setup.sh
