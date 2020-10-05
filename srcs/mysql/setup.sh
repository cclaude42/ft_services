# Setup MySQL
/usr/bin/mysql_install_db --datadir=/var/lib/mysql

cat init_file | mysql -u root
cat wordpress.sql | mysql wordpress -u root

# Start MySQL
/usr/bin/mysqld --user=root
