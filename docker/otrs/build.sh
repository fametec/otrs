#!/bin/bash

docker build --rm -t fameconsultoria/apache-otrs:latest .


docker rm -f otrs
docker run -d --name otrs --link mariadb-otrs:mariadb-otrs fameconsultoria/apache-otrs
docker logs -f otrs
