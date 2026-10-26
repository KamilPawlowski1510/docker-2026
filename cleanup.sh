#!/bin/sh

set -e

docker stop agent
docker rm agent

docker stop mcpgateway
docker rm mcpgateway

echo "Network removed"
docker network rm netassignment