ARG EDITORCONFIG_CHECKER_VERSION=1.1.1
ARG ALPINE_GLIBC_VERSION=2.29-r0

FROM alpine:latest
ARG EDITORCONFIG_CHECKER_VERSION
ARG ALPINE_GLIBC_VERSION
ENV EDITORCONFIG_CHECKER_VERSION=${EDITORCONFIG_CHECKER_VERSION}
ENV ALPINE_GLIBC_VERSION=${ALPINE_GLIBC_VERSION}

RUN apk add --no-cache ca-certificates curl
RUN curl -sLo /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${ALPINE_GLIBC_VERSION}/glibc-${ALPINE_GLIBC_VERSION}.apk \
    && apk add glibc-${ALPINE_GLIBC_VERSION}.apk \
    && rm -f glibc-${ALPINE_GLIBC_VERSION}.apk \
    && $()
RUN mkdir -p /tmp/editorconfig-checker \
    && curl -sLO https://github.com/editorconfig-checker/editorconfig-checker/releases/download/${EDITORCONFIG_CHECKER_VERSION}/ec-linux-amd64.tar.gz \
    && tar zxf ec-linux-amd64.tar.gz -C /tmp/editorconfig-checker \
    && rm -f ec-linux-amd64.tar.gz \
    && mv /tmp/editorconfig-checker/bin/ec-linux-amd64 /usr/local/bin/ec \
    && rm -rf /tmp/editorconfig-checker \
    && echo "editorconfig-checker installed version: $(ec -version)" \
    && $()
