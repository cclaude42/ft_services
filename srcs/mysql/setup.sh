# Setup MySQL
/usr/bin/mysql_install_db --datadir=/var/lib/mysql

# Start MySQL
/usr/bin/mysqld --user=root --init_file=/init_file
