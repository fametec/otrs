#!/bin/bash

docker rm -f nginx

#docker rm volume nginx-volume
#docker volume create nginx-volume
#docker run -d --name nginx --link mariadb-nginx:mariadb-nginx -v nginx-volume:/opt/nginx -e DBHOST="mariadb-nginx" fametec/nginx

docker run -d --name nginx fametec/nginx:latest
docker logs -f nginx 
# sleep 5
# docker exec -it nginx /configure.sh
