FROM --platform=${BUILDPLATFORM} golang:1.24-alpine3.21

ARG GO_JSONNET_VERSION="v0.20.0"
ARG GO_JSONNET_LINTER_VERSION="v0.20.0"
ARG JSONNET_BUNDLER_VERSION="v0.6.0"

RUN /bin/sh -c set -eux; \
    go install github.com/google/go-jsonnet/cmd/jsonnet@${GO_JSONNET_VERSION}; \
    go install github.com/google/go-jsonnet/cmd/jsonnet-lint@${GO_JSONNET_LINTER_VERSION}; \
    go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@${JSONNET_BUNDLER_VERSION};

WORKDIR /app
