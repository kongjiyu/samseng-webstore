#!/bin/sh

# ensure uploads directory exists and has correct permissions
mkdir -p ${SAMSENG_EXT_VOLUME}/uploads/products
chmod 755 ${SAMSENG_EXT_VOLUME}/uploads
chmod 755 ${SAMSENG_EXT_VOLUME}/uploads/products

# create caddy directories
mkdir -p ${SAMSENG_EXT_VOLUME}/caddy/logs
mkdir -p ${SAMSENG_EXT_VOLUME}/caddy/data
mkdir -p ${SAMSENG_EXT_VOLUME}/caddy/config
chmod -R 755 ${SAMSENG_EXT_VOLUME}/caddy

# build war file
docker build --target build-env -t samseng-war-build:latest .

# get war file and copy to ./deploy/artifacts
CONTAINER_ID=$(docker create samseng-war-build:latest)
mkdir -p deploy/artifacts
docker cp "$CONTAINER_ID":/usr/app/target/ROOT.war deploy/artifacts/
docker rm "$CONTAINER_ID"

docker cp deploy/artifacts/ROOT.war samseng-web:/opt/glassfish7/glassfish/domains/domain1/autodeploy
