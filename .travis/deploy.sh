#! /bin/bash

# Get the DOCKERFILE_TAG into our local build environment
source .travis/args/${PROJECT_NAME}.env

docker tag "${PROJECT_NAME}" "${DOCKER_USERNAME}/${PROJECT_NAME}:${DOCKERFILE_TAG}"
docker push "${DOCKER_USERNAME}/${PROJECT_NAME}:${DOCKERFILE_TAG}"
