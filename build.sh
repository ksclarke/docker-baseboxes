#! /bin/bash

#
# Run a build of all our basebox Docker images
#

echo ""
echo "################    Building the alpine-glibc Docker image    ######################"
echo ""
PROJECT_NAME=alpine-glibc .travis/build.sh

echo ""
echo "################    Building the alpine-corretto-11 Docker image    ################"
echo ""
PROJECT_NAME=alpine-corretto-11 .travis/build.sh

echo ""
echo "################    Building the alpine-maven Docker image    ######################"
echo ""
PROJECT_NAME=alpine-maven .travis/build.sh

# Clean up dangling images
docker image prune -f
