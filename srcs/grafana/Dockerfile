FROM alpine:latest

COPY datasource.yaml dashboard.yaml dashboard.json telegraf.conf setup.sh ./

# Install Grafana
RUN apk update && \
	apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ grafana

# Configure Grafana
RUN mv datasource.yaml /usr/share/grafana/conf/provisioning/datasources/ && \
	mv dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/ && \
	mv dashboard.json /usr/share/grafana/conf/provisioning/dashboards/

# Install telegraf
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ telegraf && \
	mkdir -p /etc/telegraf && \
	mv telegraf.conf /etc/telegraf/

EXPOSE 3000

CMD ./setup.sh
