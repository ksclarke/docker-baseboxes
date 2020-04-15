
FROM alpine:3.11.5

# We need a glibc compatibility layer over musl
ARG GLIBC_VERSION=2.31-r0
ARG GLIBC_BASE_URL=https://github.com/sgerrand/alpine-pkg-glibc

# We need to create a symlink to our ld library file
ARG LD_VERSION=2.31

# Locale of our instance
ARG LOCALE=en_US

# A build date that our build.sh script supplies
ARG REPO_OWNER=ksclarke
ARG REPO_EMAIL=ksclarke@ksclarke.io
ARG BUILD_DATE

# Set our UTF-8 locale
ENV LANG=${LOCALE}.UTF-8

LABEL maintainer="${REPO_EMAIL}"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date="${BUILD_DATE}"
LABEL org.label-schema.name="alpine-glibc"
LABEL org.label-schema.description="A basebox with Alpine and a glibc compatibility layer"
LABEL org.label-schema.url="https://github.com/${REPO_OWNER}/docker-baseboxes/"
LABEL org.label-schema.vcs-url="https://github.com/${REPO_OWNER}/docker-baseboxes/"

RUN set -ex && \
# Install pre-requisities
    apk add --no-cache libstdc++ ca-certificates bash && \
# Install glibc compatibility layer
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    for PACKAGE in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION} glibc-i18n-${GLIBC_VERSION} ; do \
      wget -q -O "/tmp/${PACKAGE}.apk" "${GLIBC_BASE_URL}/releases/download/${GLIBC_VERSION}/${PACKAGE}.apk" ; \
    done && \
    apk add --no-cache /tmp/*.apk && \
    rm -v /tmp/*.apk && \
# Fix ldconfig
    rm /usr/glibc-compat/lib/ld-linux-x86-64.so.2 && \
    ln -s /usr/glibc-compat/lib/ld-${LD_VERSION}.so /usr/glibc-compat/lib/ld-linux-x86-64.so.2 && \
# Set the locale
    ( /usr/glibc-compat/bin/localedef -i ${LOCALE} -f UTF-8 ${LOCALE}.UTF-8 || true ) && \
    echo "export LANG=${LOCALE}.UTF-8" > /etc/profile.d/locale.sh && \
    apk del --no-cache glibc-i18n && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
# Clean up
    rm -rf /tmp/* /var/cache/apk/* /var/cache/ldconfig /var/cache/ldconfig/aux-cache && \
# Configure local DNS
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf
