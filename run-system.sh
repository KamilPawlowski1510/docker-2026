#!/bin/sh

set -e

docker network create --driver=bridge netassignment
echo "Network started"

# NOTE: I needed to change Dockerfile line endings from CRLF to LF, otherwise the ai agent container couldn't run because "/entrypoint.sh: no such file or directory"

docker run -d --net netassignment --name database -e POSTGRES_USER=dbadmin -e POSTGRES_PASSWORD=db_password1 -e POSTGRES_DB=musicdb postgres

sleep 30
docker build --target seeder -t seeder .

docker run --rm -d --net netassignment --name seeder -e SQLITE_FILE=/app/Chinook.db -e DATABASE_URL=postgres://dbadmin:db_password1@database:5432/musicdb -v "$(pwd)/Chinook.db:/app/Chinook.db:ro" seeder

docker wait seeder
docker run -d --net netassignment --name mcpgateway -v /var/run/docker.sock:/var/run/docker.sock -v "$(pwd)/mcp_config.yaml:/mcp_config.yaml:ro" -v "$(pwd)/mcp_secret.env:/run/secrets/database-url:ro" docker/mcp-gateway:latest --transport=sse --secrets=/run/secrets/database-url --allow-unauthenticated --servers=cockroachdb --tools=execute_query --config=/mcp_config.yaml

sleep 60
docker build --target agent -t agent .

docker run --net netassignment --name aiagent -v "$(pwd)/secret.ollama-api-key:/run/secrets/openai-api-key:ro" -e MCP_SERVER_URL=http://mcpgateway:8811/sse -e DATABASE_DIALECT=PostgreSQL -e QUESTION="What are the top 3 albums by sales?" -e OPENAI_API_BASE_URL=https://ollama.com/v1 -e OPENAI_MODEL_NAME=gpt-oss:20b agent