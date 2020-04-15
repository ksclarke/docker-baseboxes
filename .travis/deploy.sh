#! /bin/bash

echo "${DOCKER_PASSWORD}" | docker login --username "${DOCKER_USERNAME}" --password-stdin;
docker tag "${PROJECT_NAME}" "${DOCKER_USERNAME}/${PROJECT_NAME}:latest"
docker push "${DOCKER_USERNAME}/${PROJECT_NAME}:latest"
