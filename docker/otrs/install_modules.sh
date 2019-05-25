#!/bin/bash

#debug
# set -x

## ITSM module

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/itsm/bundle6/:ITSM-6.0.18.opm'

## FAQ 

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/packages/:FAQ-6.0.18.opm'


## TimeAccounting

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/packages/:TimeAccounting-6.0.12.opm'


## Survey

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/packages/:Survey-6.0.11.opm'

## Complemento

#  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install 
