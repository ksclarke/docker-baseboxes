#! /bin/bash

# Set CWD to the directory from which the script is running
cd "$(dirname "$0")"

# Build the Docker images
docker build --no-cache=true --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') -t alpine-glibc .
