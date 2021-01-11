#
# A Docker basebox that has Alpine and a glibc compatibility layer installed
#

# Default values that we should be overriding
ARG ALPINE_VERSION="latest"

# Our base Alpine Docker image
FROM alpine:${ALPINE_VERSION}

# We need a glibc compatibility layer over musl
ARG GLIBC_VERSION=""
ARG GLIBC_DOWNLOAD_URL=https://github.com/sgerrand/alpine-pkg-glibc/releases/download
    
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
      wget -q -O "/tmp/${PACKAGE}.apk" "${GLIBC_DOWNLOAD_URL}/${GLIBC_VERSION}/${PACKAGE}.apk" ; \
    done && \
    apk add --no-cache /tmp/*.apk && \
    /usr/glibc-compat/bin/localedef -i "${LOCALE}" -f UTF-8 "${LANG}" && \
# Fix ldconfig warnings (assumption: there should just be one ld-*.so)
    rm /usr/glibc-compat/lib/ld-linux-x86-64.so.2 && \
    ln -s /usr/glibc-compat/lib/ld-*.so /usr/glibc-compat/lib/ld-linux-x86-64.so.2 && \
# Clean up
    apk del --no-cache .build-dependencies glibc-i18n glibc-bin && \
    rm -rf /tmp/* /etc/apk/keys/sgerrand.rsa.pub /var/cache/ldconfig /root/.wget-hsts
#
# For poking around, add Bash
# RUN apk add --no-cache bash
