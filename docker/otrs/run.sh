#!/bin/bash

docker rm -f otrs

#docker rm volume otrs-volume

#docker volume create otrs-volume

docker run -d --name otrs -v otrs-volume:/opt/otrs -e DBHOST="172.17.0.2" fametec/otrs
docker logs -f otrs &
sleep 5
# docker exec -it otrs /configure.sh
