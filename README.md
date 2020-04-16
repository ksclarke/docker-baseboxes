# Docker Baseboxes &nbsp; [![Build Status](https://travis-ci.org/ksclarke/docker-baseboxes.svg?branch=master)](https://travis-ci.org/ksclarke/docker-baseboxes)

This project is a collection of basebox Docker images.

## How to Build

These baseboxes are intended to be built by Travis-CI. They are set up to build nightly. The nightly build is pushed to DockerHub using the `latest` tag. If the future, I'll add tagged builds.

If you want to build them locally, there is a simple build script that can assist. To build all of them, type:

    ./build.sh

If you want to build just one of them, you'll need to use a command like:

    PROJECT_NAME=alpine-glibc .travis/build.sh

The "project name" should be one of this project's top level folders (that also contains a Dockerfile inside of it).

## Contact

If you have any questions feel free to <a href="mailto:ksclarke@ksclarke.io">contact me</a>; or, if you have a problem or any suggestions for improvement, open a ticket in the project's [issues queue](https://github.com/ksclarke/docker-baseboxes/issues).