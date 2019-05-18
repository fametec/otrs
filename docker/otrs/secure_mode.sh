#!/bin/bash

#debug
# set -xv

if [ -z $1 ]; then
    echo "Use: $0 on|off"
    exit 1
fi

case $1 in

    on)

      sed -i s/'$Self->{SecureMode} = 0;'/'$Self->{SecureMode} = 1;'/g /opt/otrs/Kernel/Config.pm

    ;;

    off)

      sed -i s/'$Self->{SecureMode} = 1;'/'$Self->{SecureMode} = 0;'/g /opt/otrs/Kernel/Config.pm

    ;;

    *)
      echo "unknow param, use: $0 [on|off]" 
      exit 2
    ;; 

esac


grep Secure /opt/otrs/Kernel/Config.pm


