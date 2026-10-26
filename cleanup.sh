#!/bin/sh

set -e

docker stop agent
docker rm agent

docker stop mcpgateway
docker rm mcpgateway

docker stop database
docker rm database

echo "Network removed"
docker network rm netassignment