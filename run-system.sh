#!/bin/sh

set -e

docker network create --driver=bridge netassignment
echo "Network started"