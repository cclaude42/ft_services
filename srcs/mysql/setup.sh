# Setup MySQL
/usr/bin/mysql_install_db --datadir=/var/lib/mysql

# Start MySQL in background
/usr/bin/mysqld --user=root --init_file=/init_file & sleep 3

# Initialize database
mysql wordpress -u root < wordpress.sql

# Keep container running
tail -f /dev/null
