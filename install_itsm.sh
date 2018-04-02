#!/bin/bash

#debug
set -x

## VARIAVEIS


## ITSM module

if [ ! -e ITSM-6.0.6.opm ]; then 
  
  wget -c http://ftp.otrs.org/pub/otrs/itsm/bundle6/ITSM-6.0.6.opm -O ITSM-6.0.6.opm

fi

cp ITSM-6.0.6.opm /tmp/

su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install /tmp/ITSM-6.0.6.opm'


