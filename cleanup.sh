#!/bin/sh

set -e

docker stop mcpgateway
docker rm -v mcpgateway

docker stop database
docker rm -v database

docker rmi seeder

docker rmi agent

echo "Network removed"
docker network rm netassignment