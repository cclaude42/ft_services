# Setup MySQL
/usr/bin/mysql_install_db --datadir=/var/lib/mysql

mysql -u root < init_file

# Start MySQL
/usr/bin/mysqld --user=root
