# Install OTRS





    curl -sSL "https://raw.githubusercontent.com/fameconsultoria/otrs/master/install_otrs.sh" | bash


[![asciicast](https://asciinema.org/a/238434.svg)](https://asciinema.org/a/238434)



## VARIABLES

- VERSION="6.0.17"
- LOGS="install_otrs.log"
- FQDN="suporte.fametec.com.br"
- ADMINEMAIL="suporte@fametec.com.br"
- ORGANIZATION="FAMETEC"
- MYSQL_ROOT_PASSWORD=''
- DBUSER="otrs"
- DBHOST="127.0.0.1"
- DBPORT=3306
- DBNAME="otrs"
- SYSTEMID="`< /dev/urandom tr -dc 0-9 | head -c${1:-2};echo;`"
- MYSQL_NEW_ROOT_PASSWORD="t`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;`"
- MYSQL_NEW_OTRS_PASSWORD="p`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;`"

  
