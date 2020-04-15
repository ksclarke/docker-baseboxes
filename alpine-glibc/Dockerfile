#
# A Docker basebox that has Alpine and a glibc compatibility layer installed
#

# Our base Docker image
FROM alpine:3.11.5

# We need a glibc compatibility layer over musl
ARG GLIBC_VERSION=2.31-r0
ARG GLIBC_BASE_URL=https://github.com/sgerrand/alpine-pkg-glibc
    
# We need to create a symlink to our ld library file
ARG LD_VERSION=2.31
    
# Locale of our instance
ARG LOCALE=en_US
    
# Some metadata for our Docker image
ARG REPO_OWNER=ksclarke
ARG REPO_EMAIL=ksclarke@ksclarke.io

# Set our UTF-8 locale
ENV LANG=${LOCALE}.UTF-8

# Set some metadata on our Docker image
LABEL maintainer="${REPO_EMAIL}" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.name="alpine-glibc" \
      org.label-schema.description="A basebox with Alpine and a glibc compatibility layer" \
      org.label-schema.vcs-url="https://github.com/${REPO_OWNER}/docker-baseboxes/"

RUN set -ex && \
# Install pre-requisities that are needed to build this image
    apk add --no-cache --virtual=.build-dependencies ca-certificates && \
# Install glibc compatibility layer
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    for PACKAGE in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION} glibc-i18n-${GLIBC_VERSION} ; do \
      wget -q -O "/tmp/${PACKAGE}.apk" "${GLIBC_BASE_URL}/releases/download/${GLIBC_VERSION}/${PACKAGE}.apk" ; \
    done && \
    apk add --no-cache /tmp/*.apk && \
# Fix ldconfig warnings
    rm /usr/glibc-compat/lib/ld-linux-x86-64.so.2 && \
    ln -s /usr/glibc-compat/lib/ld-${LD_VERSION}.so /usr/glibc-compat/lib/ld-linux-x86-64.so.2 && \
# Set the locale
    /usr/glibc-compat/bin/localedef --force --inputfile ${LOCALE} --charmap UTF-8 ${LOCALE}.UTF-8 && \
    echo "export LANG=${LOCALE}.UTF-8" > /etc/profile.d/locale.sh && \
# Clean up
    apk del --no-cache .build-dependencies glibc-i18n && \
    rm -rf /tmp/* /etc/apk/keys/sgerrand.rsa.pub /var/cache/ldconfig /root/.wget-hsts
#
# For poking around, add Bash
# RUN apk add --no-cache bash
