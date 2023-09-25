#!/bin/bash

# Build Keycloak Docker image using the Alpine-based Dockerfile
docker build -t keycloak -f alpine.Dockerfile .

# Run Docker Compose to start Keycloak and PostgreSQL containers
docker-compose up -d

# Optional: Check container status
docker-compose ps
