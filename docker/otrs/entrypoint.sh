#!/bin/bash

/etc/init.d/apache2 start

# /etc/init.d/cron start

su - otrs -c '/opt/otrs/bin/otrs.Daemon.pl start > /dev/null 2>&1'

su - otrs -c '/opt/otrs/bin/Cron.sh start > /dev/null 2>&1' 

cron -f
