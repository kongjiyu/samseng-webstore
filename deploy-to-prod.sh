#!/bin/sh

# build war file
docker build --target build-env -t samseng-war-build:latest .

# get war file and copy to ./deploy/artifacts
CONTAINER_ID=$(docker create samseng-war-build:latest)
mkdir -p deploy/artifacts
docker cp "$CONTAINER_ID":/usr/app/target/ROOT.war deploy/artifacts/
docker rm "$CONTAINER_ID"

docker cp deploy/artifacts/ROOT.war samseng-web:/opt/glassfish7/glassfish/domains/domain1/autodeploy
