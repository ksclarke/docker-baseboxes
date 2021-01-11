#! /bin/bash

# Set CWD to the directory from which the script is running
cd "$(dirname $0)/.."

# Get the DOCKERFILE_TAG into our local build environment
source .travis/args/${PROJECT_NAME}.env

# Get the appropriate build args for this project's build
BUILD_ARGS=$(
  for ARG in `cat .travis/args/${PROJECT_NAME}.env`; do
    if [[ $ARG != DOCKERFILE_TAG* ]]; then
      BUILD_ARG+="--build-arg $ARG ";
    fi
  done;
  echo $BUILD_ARG
)

# All images use ones we've built as bases except for alpine-glibc, which is the base of the bases
if [ ! -z "${DOCKER_USERNAME}" ] && [ "${PROJECT_NAME}" != 'alpine-glibc' ]; then
	docker build --compress --squash --build-arg DOCKER_OWNER="${DOCKER_USERNAME}/" ${BUILD_ARGS} \
	  -t "${PROJECT_NAME}:${DOCKERFILE_TAG}" "${PROJECT_NAME}"
else
    docker build --compress --squash ${BUILD_ARGS} -t "${PROJECT_NAME}:${DOCKERFILE_TAG}" "${PROJECT_NAME}"
fi
