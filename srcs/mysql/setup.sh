# Setup MySQL
/usr/bin/mysql_install_db --datadir=/var/lib/mysql

mysql wordpress -u root < wordpress.sql

# Start MySQL
/usr/bin/mysqld --user=root --init_file=/init_file
