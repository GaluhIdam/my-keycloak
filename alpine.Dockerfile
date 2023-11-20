FROM quay.io/keycloak/keycloak:latest as builder

ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_DB=postgres

WORKDIR /opt/keycloak

RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest

COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENV KC_DB=postgres
ENV KC_DB_URL=postgres://saynotodream:0p3nw0rld@localhost:5432/keycloak
ENV KC_HOSTNAME=localhost

ENV KEYCLOAK_USER=tryagain
ENV KEYCLOAK_PASSWORD=0p3nw0rld

CMD ["/opt/keycloak/bin/kc.sh", "start"]
