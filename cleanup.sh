#!/bin/sh

set -e

docker stop mcpgateway
docker rm mcpgateway

docker stop database
docker rm database

docker rmi seeder

docker rmi agent

echo "Network removed"
docker network rm netassignment