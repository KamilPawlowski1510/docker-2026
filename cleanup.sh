#!/bin/sh

set -e

echo "Stopping MCP-gateway container..."
docker stop mcpgateway
echo "Removing MCP-gateway container..."
docker rm -v mcpgateway

echo "Stopping database container..."
docker stop database
echo "Removing database container..."
docker rm -v database

echo "Removing seeder image..."
docker rmi seeder

echo "Removing AI agent image..."
docker rmi agent

echo "Removing network..."
docker network rm netassignment