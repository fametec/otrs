#!/bin/bash

#debug
#set -xv

itsm(){
	
	su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/itsm/bundle6/:ITSM-6.0.28.opm --no-ansi --quiet'

}
	
	 
faq(){

## FAQ 

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/packages/:FAQ-6.0.26.opm --no-ansi --quiet'

}


timeaccount() {

## TimeAccounting

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/packages/:TimeAccounting-6.0.16.opm --no-ansi --quiet'

}



## Survey

survey() {

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install http://ftp.otrs.org/pub/otrs/packages/:Survey-6.0.18.opm --no-ansi --quiet'

}


## Complemento Ligero Repository

ligero(){

  su - otrs -c '/opt/otrs/bin/otrs.Console.pl Admin::Package::Install https://github.com/fametec/otrs/raw/master/packages/:LigeroRepository-6.0.0.opm --no-ansi --quiet'

}


case $1 in

	itsm)
		itsm
	;;

        faq)
		faq
		;;

	timeaccount)
		timeaccount
		;;

	survey)
		survey
		;;

	ligero)
		ligero
		;;

		
	all)
		itsm
		faq
		timeaccount
		survey
		ligero
		;;

	*)

		echo "Use $0 package_name "
		echo "Packages available: "
		echo " all (all packages)"
	        echo " itsm"
	        echo " faq"
		echo " timeaccount"
	        echo " survey"
		echo " ligero"

		
		;;


esac


