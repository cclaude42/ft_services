# Setup MySQL
/usr/bin/mysql_install_db --user=root --datadir=/var/lib/mysql

# Start MySQL
/usr/bin/mysqld --user=root --datadir=/var/lib/mysql --init_file=mysql_init --console
