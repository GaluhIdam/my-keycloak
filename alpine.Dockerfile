# Use the official Alpine-based Keycloak image as the base image
FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak

# For demonstration purposes only, please make sure to use proper certificates in production instead
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore

# Build Keycloak
RUN /opt/keycloak/bin/kc.sh build

# Start a new stage for the final image
FROM quay.io/keycloak/keycloak:latest

# Copy the built Keycloak instance from the previous stage
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Change these values to point to your existing PostgreSQL database
ENV KC_DB=postgres
ENV KC_DB_URL=postgres://saynotodream:0p3nw0rld@localhost:5432/keycloak
ENV KC_HOSTNAME=localhost

# Set Keycloak admin user credentials (replace with your desired values)
ENV KEYCLOAK_USER=tryagain
ENV KEYCLOAK_PASSWORD=0p3nw0rld

# Define the entry point for the container
CMD ["/opt/keycloak/bin/kc.sh", "start", "-b", "0.0.0.0"]
