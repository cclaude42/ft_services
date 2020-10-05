# Setup MySQL
/usr/bin/mysql_install_db --datadir=/var/lib/mysql

# Start MySQL
/usr/bin/mysqld --user=root --init_file=/init_file &
sleep 5
mysql wordpress -u root < wordpress.sql
tail -f /dev/null
