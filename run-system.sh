#!/bin/sh

set -e

docker network create --driver=bridge netassignment
echo "Network started"

# NOTE: I needed to change Dockerfile line endings from CRLF to LF, otherwise the ai agent container couldn't run because "/entrypoint.sh: no such file or directory"