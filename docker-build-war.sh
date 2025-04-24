#!/usr/bin/env bash
set -e

# 1) Build both stages of the multi-stage Dockerfile
docker build --target build-env -t local-build:latest .

# 2) Create a container from the final image (even though the final image is GlassFish-based,
#    the build artifacts exist in the intermediate layers).
CONTAINER_ID=$(docker create local-build:latest)

# 3) Copy out the compiled WAR from the "build-env" layer
#    (assuming the WAR is named web-1.0.war; adjust as needed)
mkdir -p deploy/artifacts
docker cp "$CONTAINER_ID":/usr/app/target/ROOT.war deploy/artifacts/

# 4) Remove the temp container
docker rm "$CONTAINER_ID"

# 5) Optional: Remove the intermediate build image to save space
docker rmi local-build:latest

echo "WAR copied to deploy/artifacts/"
echo "Done building WAR in Docker."