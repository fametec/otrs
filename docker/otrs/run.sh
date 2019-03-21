#!/bin/bash

docker rm -f otrs

docker rm volume otrs-volume

docker volume create otrs-volume

docker run -d --name otrs --link mariadb-otrs:mariadb-otrs -v otrs-volume:/opt/otrs -e DBHOST="mariadb-otrs" fametec/otrs
docker logs -f otrs &
# sleep 5
# docker exec -it otrs /configure.sh
