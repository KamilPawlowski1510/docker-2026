#!/bin/sh

set -e

docker stop aiagent
docker rm aiagent

docker stop mcpgateway
docker rm mcpgateway

docker stop database
docker rm database

docker rmi seeder

echo "Network removed"
docker network rm netassignment