#!/bin/bash

#su -c "/opt/otrs/bin/otrs.Daemon.pl start" -s /bin/bash otrs

# su - otrs -c '/opt/otrs/bin/Cron.sh start > /dev/null 2>&1'

# exec /usr/sbin/apache2 -DFOREGROUND

NAME=apache2
DAEMON=/usr/sbin/$NAME

APACHE_CONFDIR=/etc/apache2
APACHE_ENVVARS=$APACHE_CONFDIR/envvars

export APACHE_CONFDIR APACHE_ENVVARS


ENV="env -i LANG=C PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

APACHE2CTL="$ENV apache2ctl"


$APACHE2CTL start


while true; do sleep 1000; done
