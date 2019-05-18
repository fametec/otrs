#!/bin/bash

#debug
set -x

cd modules

## ITSM module

if [ ! -e ITSM-6.0.18.opm ]; then 
  
  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/itsm/bundle6/:ITSM-6.0.18.opm'

else

  cp ITSM-6.0.18.opm /tmp/

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install /tmp/ITSM-6.0.18.opm'

fi

## FAQ 

if [ ! -e FAQ-6.0.18.opm ]; then

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/packages/:FAQ-6.0.18.opm'

else 

  cp FAQ-6.0.18.opm /tmp/

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install /tmp/FAQ-6.0.18.opm'

fi

## TimeAccounting

if [ ! -e TimeAccounting-6.0.12.opm ]; then

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/packages/:TimeAccounting-6.0.12.opm'

else
  
  cp TimeAccounting-6.0.123.opm /tmp/

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install /tmp/TimeAccounting-6.0.12.opm'

fi

## Survey

if [ ! -e Survey-6.0.11.opm ]; then 

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/packages/:Survey-6.0.11.opm'

else

  cp Survey-6.0.11.opm /tmp/

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install /tmp/Survey-6.0.11.opm'

fi
