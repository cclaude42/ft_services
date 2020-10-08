FROM alpine:latest

COPY influxdb.yaml setup.sh ./

# Install Grafana
RUN apk update && \
	apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ grafana

# Configure Grafana
RUN mv influxdb.yaml /usr/share/grafana/conf/provisioning/datasources/

EXPOSE 3000

CMD ./setup.sh
