#!/bin/bash

sudo docker build --rm -t fameconsultoria/mariadb-otrs:latest .


sudo docker stop mariadb-otrs
sudo docker rm mariadb-otrs

sudo docker run -d --name mariadb-otrs fameconsultoria/mariadb-otrs:latest

sudo docker logs -f mariadb-otrs


