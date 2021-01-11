#
# A Docker basebox for compiling Java using Maven
#

ARG DOCKER_OWNER=""
ARG ALPINE_CORRETTO_11_VERSION="latest"

# Our base Docker image
FROM ${DOCKER_OWNER}alpine-corretto-11:${ALPINE_CORRETTO_11_VERSION}

# The version of Maven that we're using
ARG MAVEN_VERSION=""
ARG MAVEN_SHA=""
ARG MAVEN_BASE_URL="https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries"

# Some metadata for our Docker image
ARG REPO_OWNER="ksclarke"
ARG REPO_EMAIL="ksclarke@ksclarke.io"

# Set the Maven home environmental property
ENV MAVEN_HOME="/usr/share/maven"

# Set some metadata on our Docker image
LABEL maintainer="${REPO_EMAIL}" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.name="alpine-maven" \
      org.label-schema.description="A basebox with Maven and the Corretto-11 JVM" \
      org.label-schema.vcs-url="https://github.com/${REPO_OWNER}/docker-baseboxes/"

# Install Maven and Bash (since Maven builds sometimes use that)
RUN set -ex && apk add --no-cache bash && \
    mkdir -p /usr/share/maven /usr/share/maven/ref && \
    wget -q -O /tmp/apache-maven.tar.gz "${MAVEN_BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz" && \
# Check the download's SHA512 (the double space in the `echo` is necessary)
    echo "${MAVEN_SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - && \
    tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
# Clean up
    rm -rf /tmp/*
