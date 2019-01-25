#!/bin/bash

docker rm -f otrs
docker run -d --name otrs -e DBHOST="172.17.0.2" fameconsultoria/otrs
#  docker run -d --name otrs fameconsultoria/otrs
# docker run -it --name otrs --link mariadb-otrs:mariadb-otrs fameconsultoria/otrs /bin/bash
docker logs -f otrs &

docker exec -it otrs /configure.sh 
