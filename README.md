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

  

# ((OTRS)) Community Edition 6.0.18


## require MariaDB
 
    docker volume create mariadb-otrs-volume
    docker run -d --name=mariadb-otrs \
        -v mariadb-otrs-volume:/var/lib/mysql \
        fametec/mariadb-otrs:latest


## create volume

    docker volume create otrs-volume
    docker run -d --name otrs \
        --link mariadb-otrs:mariadb-otrs  \
        -v otrs-volume:/opt/otrs \
        fametec/otrs:latest


## docker-compose.yaml
    version: '3.2'
    services:
      otrs: 
        image: fametec/otrs:latest
        container_name: otrs
        ports:
        - 80:80
        - 443:443
        volumes:
        - otrs-volume:/opt/otrs:rw
        depends_on:
         - mariadb-otrs
      mariadb-otrs:
        image: fametec/mariadb-otrs:latest
        container_name: mariadb-otrs
        ports:
        - 3306:3306
        volumes:
        - mariadb-otrs-volume:/var/lib/mysql:rw
    volumes:
     otrs-volume:
     mariadb-otrs-volume:




## Video 

[![asciicast](https://asciinema.org/a/IEqSk4A4cgsxRTgKL9OUVcGwo.svg)](https://asciinema.org/a/IEqSk4A4cgsxRTgKL9OUVcGwo)

## Description 
  
((OTRS)) Community Edition – The Flexible Open Source Service Management Software

((OTRS)) Community Edition is one of the most successful and long-lasting open source projects in the area of help desk and IT service management worldwide. More than 5,000 active community members improve the service management software with every release by reporting bugs, adding self-developed improvements or new functionalities, and maintaining and extending the 38 supported languages. Thanks to the open source code that is constantly reviewed by the manufacturer and the community, the open source software ((OTRS)) Community Edition is not only more secure than proprietary software but also more flexible. This is evidenced by 170,000 installations in different industry sectors such as IT & telecommunications, government, healthcare, manufacturing, education and consumer products.

https://community.otrs.com


https://www.fametec.com.br

