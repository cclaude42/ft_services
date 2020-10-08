FROM alpine:latest

COPY setup.sh ./

# Install Grafana
RUN apk update && \
	apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ grafana

EXPOSE 3000

CMD ./setup.sh
