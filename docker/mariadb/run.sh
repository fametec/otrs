#!/bin/bash

docker rm -f mariadb-otrs
docker run -d --name=mariadb-otrs fametec/mariadb-otrs:latest


#docker volume rm mariadb-otrs-volume
#docker volume create mariadb-otrs-volume
#docker run \
#	-d \
#	--name=mariadb-otrs \
#	-v mariadb-otrs-volume:/var/lib/mysql \
#	fametec/mariadb-otrs:latest
#

docker logs -f mariadb-otrs &


