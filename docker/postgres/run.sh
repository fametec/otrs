#!/bin/bash

docker rm -f postgresql-otrs
docker run -d --name=postgresql-otrs fametec/postgresql-otrs:latest


docker logs -f postgresql-otrs &


