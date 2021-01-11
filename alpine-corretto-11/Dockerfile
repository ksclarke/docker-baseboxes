#
# A Docker basebox that has Corretto-11 installed
#

ARG DOCKER_OWNER=""
ARG ALPINE_GLIBC_VERSION="latest"

# Our base Docker image
FROM ${DOCKER_OWNER}alpine-glibc:${ALPINE_GLIBC_VERSION}

# Releases and checksums are listed on https://github.com/corretto/corretto-11/releases
ARG JDK_DOWNLOADS="https://corretto.aws/downloads/resources"
ARG JDK_VERSION=""
ARG JDK_MD5_CHECKSUM=""

# Some metadata for our Docker image
ARG REPO_OWNER="ksclarke"
ARG REPO_EMAIL="ksclarke@ksclarke.io"

# Set some environmental properties for our container
ENV JAVA_HOME=/opt/jdk \
    PATH=$PATH:/opt/jdk/bin

# Set some metadata on our Docker image
LABEL maintainer="${REPO_EMAIL}" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.name="alpine-corretto-11" \
      org.label-schema.description="A basebox with Alpine and the Corretto-11 JVM" \
      org.label-schema.vcs-url="https://github.com/${REPO_OWNER}/docker-baseboxes/"

RUN set -ex && \
# Install Corretto
    wget -q -O /tmp/corretto.tar.gz \
      ${JDK_DOWNLOADS}/${JDK_VERSION}/amazon-corretto-${JDK_VERSION}-alpine-linux-x64.tar.gz && \
    echo "${JDK_MD5_CHECKSUM}  /tmp/corretto.tar.gz" > /tmp/corretto.tar.gz.md5 && \
    md5sum -c /tmp/corretto.tar.gz.md5 && \
    gunzip /tmp/corretto.tar.gz && tar -C /opt -xf /tmp/corretto.tar && \
    ln -s /opt/amazon-corretto-${JDK_VERSION}-alpine-linux-x64 /opt/jdk && \
# Clean up
    rm -rf /opt/jdk/*src.zip /tmp/*
#
# For poking around, add Bash
# RUN apk add --no-cache bash
