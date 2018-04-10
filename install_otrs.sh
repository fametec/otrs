#!/bin/sh
#
# versao 0.1
#
# NOME
#   install_otrs.sh
#
# DESCRICAO
#   Instala o OTRS com banco MariaDB incluindo suas dependencias.
#
# NOTA
#
#   Execute ./install_otrs.sh 
#   
# LICENÇAS
#
#   Este script está licenciado sob a GPLv3. 
#
# MODIFICADO_POR  (DD/MM/YYYY)
#   Eduardo Fraga  2018-04-10 - Criado por Eduardo Fraga <eduardo@fameconsultoria.com.br>
#                                
#

#debug
# set -x

## VARIAVEIS

FQDN="suporte.eftech.com.br"
ADMINEMAIL="suporte@eftech.com.br"
ORGANIZATION="EF-TECH"
MYSQL_ROOT_PASSWORD=''
DBUSER="otrs"
DBHOST="127.0.0.1"
DBNAME="otrs"
SYSTEMID="`< /dev/urandom tr -dc 0-9 | head -c${1:-2};echo;`"
MYSQL_NEW_ROOT_PASSWORD="`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;`"
MYSQL_NEW_OTRS_PASSWORD="`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;`"

## CONSTANTES

MYSQL="mysql -u root -p${MYSQL_NEW_ROOT_PASSWORD}"
CURL="curl -d action="/otrs/installer.pl" -d Action="Installer""



## Desativar SELINUX

sed -i s/enforcing/permissive/g /etc/selinux/config

setenforce 0

## Instalar mariadb-server

yum -y install mariadb-server expect epel-release


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

## Configuração de segurança do banco

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

if [ -e otrs-6.0.6-01.noarch.rpm ]; then
  
  yum -y install otrs-6.0.6-01.noarch.rpm

else 
  
  yum -y install http://ftp.otrs.org/pub/otrs/RPMS/rhel/7/otrs-6.0.6-01.noarch.rpm

fi


## Dependencias

yum -y install \
"perl(Crypt::Eksblowfish::Bcrypt)" \
"perl(JSON::XS)" \
"perl(Mail::IMAPClient)" \
"perl(Authen::NTLM)" \
"perl(ModPerl::Util)" \
"perl(Text::CSV_XS)" \
"perl(YAML::XS)"


# Criando database

${MYSQL} -e "create database otrs"
${MYSQL} -e "CREATE USER otrs@localhost IDENTIFIED BY '"${MYSQL_NEW_OTRS_PASSWORD}"';"
${MYSQL} -e "GRANT ALL on otrs.* TO otrs@localhost;"


## Configurando o Bando de dados

#sed -i s/'some-pass'/${MYSQL_NEW_OTRS_PASSWORD}/g /opt/otrs/Kernel/Config.pm

## Deploy database

#$MYSQL otrs < /opt/otrs/scripts/database/otrs-schema.mysql.sql
#$MYSQL otrs < /opt/otrs/scripts/database/otrs-initial_insert.mysql.sql
#$MYSQL otrs < /opt/otrs/scripts/database/otrs-schema-post.mysql.sql

## Iniciando serviço

su - otrs -c '/opt/otrs/bin/otrs.Daemon.pl start > /dev/null 2>&1'
su - otrs -c '/opt/otrs/bin/Cron.sh start > /dev/null 2>&1'



## Restart httpd

systemctl enable httpd
systemctl restart httpd


## CURL 

# passo 1
$CURL -d Subaction="License" -d submit="Submit" http://localhost/otrs/installer.pl

# passo 2
$CURL -d Subaction="Start" -d submit="Accept license and continue" http://localhost/otrs/installer.pl

# passo 3
$CURL -d Subaction="DB" -d DBType="mysql" -d DBInstallType="UseDB" -d submit="FormDBSubmit" http://localhost/otrs/installer.pl

# passo 4
$CURL -d Subaction="DBCreate" -d DBType="mysql" -d InstallType="UseDB" -d DBUser=$DBUSER -d DBPassword="$MYSQL_NEW_OTRS_PASSWORD" -d DBHost=$DBHOST -d DBName=$DBNAME -d submit="FormDBSubmit" http://localhost/otrs/installer.pl 

# passo 5
$CURL -d Subaction="System" -d submit="Submit" http://localhost/otrs/installer.pl

# passo 6
$CURL -d Subaction="ConfigureMail" -d SystemID=$SYSTEMID FQDN=$FQDN -d AdminEmail=$ADMINEMAIL -d Organization=$ORGANIZATION -d LogModule="Kernel::System::Log::SysLog" DefaultLanguage="pt_BR" -d CheckMXRecord="0" -d submit="Submit" http://localhost/otrs/installer.pl

# passo 7
$CURL -d Subaction="Finish" -d Skip="0" -d button="Skip this step" http://localhost/otrs/installer.pl



## Set Admin Password

su - otrs -c "/opt/otrs/bin/otrs.Console.pl Admin::User::SetPassword root@localhost $MYSQL_NEW_OTRS_PASSWORD"


## FIM

echo ""
echo ""
echo "MYSQL root@localhost: $MYSQL_NEW_ROOT_PASSWORD"
echo ""
echo "MYSQL otrs@localhost: $MYSQL_NEW_OTRS_PASSWORD"
echo ""
echo "Login: otrs@localhost"
echo ""
echo "Password: $MYSQL_NEW_OTRS_PASSWORD"
echo ""


