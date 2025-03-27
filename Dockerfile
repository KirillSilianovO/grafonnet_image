FROM --platform=${BUILDPLATFORM} alpine:3.17

RUN /bin/sh -c set -eux; \
    echo ${BUILDPLATFORM}; \