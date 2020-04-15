#! /bin/bash

# Set CWD to the directory from which the script is running
cd "$(dirname "$0")"

# Build the Docker images
docker build \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  --no-cache=true -t alpine-glibc .
