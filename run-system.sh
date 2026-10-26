#!/bin/sh

set -e

docker network create --driver=bridge netassignment
echo "Network started"

# NOTE: I needed to change Dockerfile line endings from CRLF to LF, otherwise the ai agent container couldn't run because "/entrypoint.sh: no such file or directory"

docker run -d --net netassignment --name database -e POSTGRES_USER=dbadmin -e POSTGRES_PASSWORD=db_password1 -e POSTGRES_DB=musicdb postgres

sleep 30
docker build --target seeder -t seeder .

docker run --rm -d --net netassignment --name seeder -e SQLITE_FILE=/app/Chinook.db -e DATABASE_URL=postgres://dbadmin:db_password1@database:5432/musicdb -v "$(pwd)/Chinook.db:/app/Chinook.db:ro" seeder