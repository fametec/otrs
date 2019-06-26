#!/bin/bash

set -x

SYSTEMID=$(( ( RANDOM % 99 )  + 1 ))

CURL="curl -sSL -d action="/otrs/installer.pl" -d Action="Installer""

## CURL 

# passo 1
$CURL \
-d Subaction="License" \
-d submit="Submit" \
http://localhost/otrs/installer.pl  >> /tmp/${0}.log

# passo 2
$CURL \
-d Subaction="Start" \
-d submit="Accept license and continue" \
http://localhost/otrs/installer.pl >> /tmp/${0}.log

# passo 3
$CURL \
-d Subaction="DB" \
-d DBType="$DB_TYPE" \
-d DBInstallType="UseDB" \
-d submit="FormDBSubmit" \
http://localhost/otrs/installer.pl >> /tmp/${0}.log

# passo 4
$CURL \
-d Subaction="DBCreate" \
-d DBType="$DB_TYPE" \
-d InstallType="UseDB" \
-d DBUser=$DB_USER \
-d DBPassword="$DB_PASSWORD" \
-d DBHost=$DB_HOST \
-d DBName=$DB_NAME \
-d submit="FormDBSubmit" \
http://localhost/otrs/installer.pl >> /tmp/${0}.log

# passo 5
$CURL \
-d Subaction="System" \
-d submit="Submit" \
http://localhost/otrs/installer.pl >> /tmp/${0}.log

# passo 6
$CURL \
-d Subaction="ConfigureMail" \
-d SystemID=$SYSTEMID \
-d FQDN="$FQDN" \
-d AdminEmail="$ADMINEMAIL" \
-d Organization="$ORGANIZATION" \
-d LogModule="Kernel::System::Log::File" \
-d DefaultLanguage="$LANGUAGE" \
-d CheckMXRecord="0" \
-d submit="Submit" \
http://localhost/otrs/installer.pl >> /tmp/${0}.log

# passo 7
$CURL \
-d Subaction="Finish" \
-d Skip="0" \
-d button="Skip this step" \
http://localhost/otrs/installer.pl >> /tmp/${0}.log


## Set Admin Password

su - otrs -c "/opt/otrs/bin/otrs.Console.pl Admin::User::SetPassword root@localhost $DB_PASSWORD --no-ansi --quiet"

## Enable Secure Mode

/secure_mode.sh on

## Install All Modules

/install_modules.sh all



