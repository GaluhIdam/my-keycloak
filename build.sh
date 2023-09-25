#!/bin/bash

# Build the Keycloak container
docker-compose build

# Start the containers in detached mode
docker-compose up -d

# Wait for Keycloak to be up and running (you can adjust the timeout as needed)
echo "Waiting for Keycloak to start..."
until [ "$(docker-compose exec keycloak curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/auth/)" == "200" ]; do
    sleep 5
done

# Display a message once Keycloak is ready
echo "Keycloak is up and running at http://localhost:8080/auth/"

# You can add additional setup steps here if needed

# To stop the containers, you can run: docker-compose down
