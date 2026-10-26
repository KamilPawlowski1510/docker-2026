#!/bin/sh

set -e

docker stop agent
docker rm agent

echo "Network removed"
docker network rm netassignment