#!/bin/bash

# set -x

CURL="curl -sSL -d action="/otrs/installer.pl" -d Action="Installer""

## CURL 

# passo 1
$CURL -d Subaction="License" -d submit="Submit" http://localhost/otrs/installer.pl

# passo 2
$CURL -d Subaction="Start" -d submit="Accept license and continue" http://localhost/otrs/installer.pl

# passo 3
$CURL -d Subaction="DB" -d DBType="mysql" -d DBInstallType="UseDB" -d submit="FormDBSubmit" http://localhost/otrs/installer.pl

# passo 4
$CURL -d Subaction="DBCreate" -d DBType="mysql" -d InstallType="UseDB" -d DBUser=$MYSQL_USER -d DBPassword="$MYSQL_PASSWORD" -d DBHost=$MYSQL_HOST -d DBName=$MYSQL_DATABASE -d submit="FormDBSubmit" http://localhost/otrs/installer.pl 

# passo 5
$CURL -d Subaction="System" -d submit="Submit" http://localhost/otrs/installer.pl

# passo 6
$CURL -d Subaction="ConfigureMail" -d SystemID=$SYSTEMID FQDN=$FQDN -d AdminEmail=$ADMINEMAIL -d Organization=$ORGANIZATION -d LogModule="Kernel::System::Log::SysLog" DefaultLanguage="pt_BR" -d CheckMXRecord="0" -d submit="Submit" http://localhost/otrs/installer.pl

# passo 7
$CURL -d Subaction="Finish" -d Skip="0" -d button="Skip this step" http://localhost/otrs/installer.pl


## Set Admin Password

su - otrs -c "/opt/otrs/bin/otrs.Console.pl Admin::User::SetPassword root@localhost $MYSQL_PASSWORD"


/secure_mode.sh on

/install_modules.sh
