#!/bin/bash

docker stop $(docker ps -aq)
docker system prune --all --force
docker volume rm $(docker volume ls -q)