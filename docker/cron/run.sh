#!/bin/bash


docker stop otrs-cron

docker rm otrs-cron

docker run -d --name otrs-cron -v otrs:/opt/otrs -e DBHOST="172.17.0.2" fametec/otrs-cron



