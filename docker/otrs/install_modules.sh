#!/bin/bash

#debug
#set -x

cd modules

## ITSM module

if [ ! -e ITSM-6.0.17.opm ]; then 
  
  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/itsm/bundle6/:ITSM-6.0.17.opm'

else

  cp ITSM-6.0.17.opm /tmp/

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install /tmp/ITSM-6.0.17.opm'

fi

## FAQ 

if [ ! -e FAQ-6.0.5.opm ]; then

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/packages/:FAQ-6.0.5.opm'

else 

  cp FAQ-6.0.5.opm /tmp/

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install /tmp/FAQ-6.0.5.opm'

fi

## TimeAccounting

if [ ! -e TimeAccounting-6.0.3.opm ]; then

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/packages/:TimeAccounting-6.0.3.opm'

else
  
  cp TimeAccounting-6.0.3.opm /tmp/

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install /tmp/TimeAccounting-6.0.3.opm'

fi


