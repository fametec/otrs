#!/bin/bash


## Desativar SELINUX

# sed -i s/enforcing/permissive/g /etc/selinux/config


## Instalar mariadb-server

yum -y install mariadb-server expect


## Configurar mysql

cat <<EOF > /etc/my.cnf.d/zotrs.cnf
[mysqld]
max_allowed_packet   = 64M
query_cache_size     = 32M
innodb_log_file_size = 256M
character-set-server = utf8
collation-server     = utf8_general_ci
EOF

rm -rf /var/lib/mysql/ib*

## Restart do mysql

systemctl restart mariadb


# Criando database

# mysql -e "create database otrs"
# mysql -e "CREATE USER otrs@localhost IDENTIFIED BY 'q1w2E#R$';"
# mysql -e "GRANT ALL on otrs.* TO otrs@localhost;"


## Configuração de segurança do banco

MYSQL_ROOT_PASSWORD=''
MYSQL_NEW_ROOT_PASSWORD='q1w2E#R$'
SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Change the root password?\"
send \"y\r\"
expect \"New password:\"
send \"$MYSQL_NEW_ROOT_PASSWORD\r\"
expect \"Re-enter new password:\"
send \"$MYSQL_NEW_ROOT_PASSWORD\r\" 
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"y\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"

## Download e Install OTRS

yum -y install http://ftp.otrs.org/pub/otrs/RPMS/rhel/7/otrs-6.0.6-01.noarch.rpm


## Configurando o Bando de dados

#$PASSWD = `su - otrs -c '/opt/otrs/bin/otrs.Console.pl Maint::Database::PasswordCrypt q1w2Q!W@'

sed -i s/'some-pass'/'q1w2E#R$'/g /opt/otrs/Kernel/Config.pm

## Deploy database

# mysql -u root -pq1w2E#R$ otrs < /opt/otrs/scripts/database/otrs-schema.mysql.sql
# mysql -u root -pq1w2E#R$ otrs < /opt/otrs/scripts/database/otrs-initial_insert.mysql.sql

## Iniciando serviço

su - otrs -c '/opt/otrs/bin/otrs.Daemon.pl start'
su - otrs -c '/opt/otrs/bin/Cron.sh start'


systemctl enable httpd
systemctl restart httpd
