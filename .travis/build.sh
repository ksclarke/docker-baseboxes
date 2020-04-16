#! /bin/bash

# Set CWD to the directory from which the script is running
cd "$(dirname "$0")/.."

# All images use ones we're built as bases except alpine-glibc
if [ ! -z "$DOCKER_USERNAME" ] && [ $PROJECT_NAME != 'alpine-glibc' ]; then
	DOCKER_OWNER="${DOCKER_USERNAME}/"
fi

# Build the Docker images
docker build --compress --squash --build-arg DOCKER_OWNER=$DOCKER_OWNER -t $PROJECT_NAME $PROJECT_NAME
