# Start telegraf
/usr/bin/telegraf &

# Start influxdb
/usr/sbin/influxd & sleep 3

# Initialize database
influx -execute "CREATE DATABASE grafana"
influx -execute "CREATE USER graf_admin WITH PASSWORD '10101'"
influx -execute "GRANT ALL ON grafana TO graf_admin"

# Keep container running
tail -f /dev/null
