#!/bin/bash

# Build the Keycloak container
docker-compose build

# Start the containers in detached mode
docker-compose up -d

# Wait for Keycloak to start (adjust timeout as needed)
echo "Waiting for Keycloak to start..."
sleep 10

# Display a message once Keycloak is ready
echo "Keycloak is up and running at http://localhost:8080/auth/"

# You can add additional setup steps here if needed

# To stop the containers, you can run: docker-compose down
