#!/bin/bash

rm -rf modules
rm -rf coldbox
rm server-start.sh

docker-compose -f bin/docker-compose.yml build 
docker-compose -f bin/docker-compose.yml up -d 