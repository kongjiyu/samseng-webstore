#!/usr/bin/env pwsh
# Stop on error
$ErrorActionPreference = 'Stop'

# 1) Build both stages of the multi-stage Dockerfile
docker build --target build-env -t local-build:latest .

# 2) Create a container from that final image
$containerId = docker create local-build:latest

# 3) Make sure the deploy/artifacts folder exists
New-Item -ItemType Directory -Path '.\deploy\artifacts' -Force | Out-Null

# 4) Copy out the compiled WAR
docker cp "$containerId`:/usr/app/target/web-1.0.war" .\deploy\artifacts\

# 5) Remove the temp container
docker rm $containerId

Write-Host "WAR copied to deploy/artifacts/"
Write-Host "Done building WAR in Docker."