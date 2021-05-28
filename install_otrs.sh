#!/bin/sh
#
# versao 0.4
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
# MODIFICADO_POR  (YYYY-MM-DD)
#   Eduardo Fraga  2018-04-10 - Criado por Eduardo Fraga <eduardo@fameconsultoria.com.br>
#   Eduardo Fraga  2019-03-02 - Re-factory por Eduardo Fraga <eduardo@fameconsultoria.com.br>
#   Eduardo Fraga  2019-08-27 - Upgrade to 6.0.21
#   Eduardo Fraga  2020-02-26 - Upgrade to 6.0.30 and Archive project
#                                

#debug
# set -x

## VARIABLES

VERSION="6.0.24"
LOGS="install_otrs.log"
FQDN="suporte.fametec.com.br"
ADMINEMAIL="suporte@fametec.com.br"
ORGANIZATION="FAMETEC"
MYSQL_ROOT_PASSWORD=''
DBUSER="otrs"
DBHOST="127.0.0.1"
DBPORT=3306
DBNAME="otrs"
SYSTEMID="`< /dev/urandom tr -dc 0-9 | head -c${1:-2};echo;`"
MYSQL_NEW_ROOT_PASSWORD="t`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;`"
MYSQL_NEW_OTRS_PASSWORD="p`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;`"

## CONSTANTES

MYSQL="mysql -u root -p${MYSQL_NEW_ROOT_PASSWORD}"
CURL="curl -d action="/otrs/installer.pl" -d Action="Installer""

functionLog () { 

cat <<EOF > $LOGS
VARIABLES:
FQDN=$FQDN
ADMINEMAIL=$ADMINEMAIL
ORGANIZATION=$ORGANIZATION
MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
DBUSER=$DBUSER
DBHOST=$DBHOST
DBNAME=$DBNAME
SYSTEMID=$SYSTEMID
MYSQL_NEW_ROOT_PASSWORD=$MYSQL_NEW_ROOT_PASSWORD
MYSQL_NEW_OTRS_PASSWORD=$MYSQL_NEW_OTRS_PASSWORD
MYSQL=$MYSQL
CURL=$CURL
EOF

}


functionDisableSELinux () {

    sed -i s/enforcing/permissive/g /etc/selinux/config
    setenforce 0

}

functionEnableFirewall () {
    
    firewall-cmd --zone=public --add-service=https --permanent
    firewall-cmd --zone=public --add-service=http --permanent

    systemctl enable --now firewalld

}

functionDisableFirewall () {

    systemctl disable --now firewalld

}

functionInstallDataBase () {

    yum -y install \
	mariadb-server \
	expect \
	epel-release

}

functionConfigDataBase () {

    cat <<EOF > /etc/my.cnf.d/zotrs.cnf
[mysqld]
max_allowed_packet   = 64M
query_cache_size     = 32M
innodb_log_file_size = 256M
character-set-server = utf8
collation-server     = utf8_general_ci
EOF

    rm -rf /var/lib/mysql/ib*

    systemctl restart mariadb

} 

functionSecureDataBase () {

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

} 


functionInstallOTRS () {


    # yum -y install http://ftp.otrs.org/pub/otrs/RPMS/rhel/7/otrs-${VERSION}-01.noarch.rpm 

    

	curl -OL https://github.com/fametec/otrs-archived/archive/rel-6_0_30.tar.gz
	tar -zxvf rel-6_0_30.tar.gz
	mv otrs-archived-rel-6_0_30 /opt/otrs
	perl /opt/otrs/bin/otrs.CheckModules.pl

	


    useradd -d /opt/otrs -c 'OTRS user' otrs

    usermod -G apache otrs


    cp /opt/otrs/Kernel/Config.pm.dist /opt/otrs/Kernel/Config.pm



    perl -cw /opt/otrs/bin/cgi-bin/index.pl

    perl -cw /opt/otrs/bin/cgi-bin/customer.pl

    perl -cw /opt/otrs/bin/otrs.Console.pl



    ln -s /opt/otrs/scripts/apache2-httpd.include.conf /etc/httpd/conf.d/zzz_otrs.conf



    cd /opt/otrs/

    bin/otrs.SetPermissions.pl




}

functionInstallDependences () {


    yum -y install "perl(Archive::Tar)" \
    "perl(Archive::Zip)" \
    "perl(Crypt::Eksblowfish::Bcrypt)" \
    "perl(Date::Format)" \
    "perl(DateTime)" \
    "perl(DateTime::TimeZone)" \
    "perl(Encode::HanExtra)" \
    "perl(IO::Socket::SSL)" \
    "perl(JSON::XS)" \
    "perl(Mail::IMAPClient)" \
    "perl(IO::Socket::SSL)" \
    "perl(Authen::SASL)" \
    "perl(Authen::NTLM)" \
    "perl(ModPerl::Util)" \
    "perl(Moo)" \
    "perl(Net::DNS)" \
    "perl(Net::LDAP)" \
    "perl(Template)" \
    "perl(Template::Stash::XS)" \
    "perl(Text::CSV_XS)" \
    "perl(XML::LibXML)" \
    "perl(XML::LibXSLT)" \
    "perl(XML::Parser)" \
    "perl(YAML::XS)" \
    "perl(namespace::clean)" \
    "perl(Sys::Syslog)"



    yum -y -q install perl-CPAN

    cat <<EOF | perl -MCPAN -e 'shell' 
yes
local::lib
yes
yes
exit
EOF


    perl -MCPAN -e 'install Moo'; 
    echo 'n' | perl -MCPAN -e 'install IO::Socket::SSL';  
    perl -MCPAN -e 'install Net::SMTP'; 

    yum -y install mod_ssl

}


functionCreateDataBase () {

${MYSQL} -e "create database otrs"
${MYSQL} -e "CREATE USER otrs@localhost IDENTIFIED BY '"${MYSQL_NEW_OTRS_PASSWORD}"';"
${MYSQL} -e "GRANT ALL on otrs.* TO otrs@localhost;"


}

functionStartOtrs () {

su - otrs -c '/opt/otrs/bin/otrs.Daemon.pl start > /dev/null 2>&1'

systemctl enable --now httpd
systemctl restart httpd

}


functionInstallWebGui () {

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


} 



functionCron () {

    cd /opt/otrs/var/cron
    
    for foo in *.dist; do cp $foo `basename $foo .dist`; done
    
    su - otrs -c '/opt/otrs/bin/Cron.sh start > /dev/null 2>&1'


}

functionSetPassword () {

su - otrs -c "/opt/otrs/bin/otrs.Console.pl Admin::User::SetPassword root@localhost $MYSQL_NEW_OTRS_PASSWORD"

}

functionBackupJob () {

    cat <<EOF > /etc/cron.daily/backup-otrs.sh
#!/bin/sh

# Backup OTRS

/opt/otrs/scripts/backup.pl -d /backup
EXITVALUE=\$?
if [ \$EXITVALUE != 0 ]; then
    /usr/bin/logger -t OTRS "ALERT exited abnormally with [\$EXITVALUE]"
fi

# Apagar backup com mais de 30d

find /backup/ -mtime +30 -delete
EXITVALUE=\$?
if [ \$EXITVALUE != 0 ]; then
    /usr/bin/logger -t OTRS "ALERT exited abnormally with [\$EXITVALUE]"
fi

exit 0

EOF

    chmod +x /etc/cron.daily/backup-otrs.sh

} 


functionShowCredentials () {

  local SHOW="

===================================================

MYSQL root@localhost: $MYSQL_NEW_ROOT_PASSWORD

MYSQL otrs@localhost: $MYSQL_NEW_OTRS_PASSWORD

Login: root@localhost

Password: $MYSQL_NEW_OTRS_PASSWORD

===================================================

";

  echo "$SHOW"

  echo "$SHOW" >> $LOGS

}





 

EXECUTE="functionLog 
functionDisableSELinux
functionDisableFirewall
functionInstallDataBase
functionConfigDataBase
functionSecureDataBase
functionCreateDataBase
functionInstallDependences
functionInstallOTRS
functionStartOtrs
functionInstallWebGui
functionSetPassword
functionCron
functionBackupJob"


for job in $EXECUTE; do

  echo "Run $job... "

  $job >> $LOGS 2>&1

  if [ $? -eq 0 ]; then
    echo "ok" 
  else 
    echo "fail" 
  fi
done

functionShowCredentials 



