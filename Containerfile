ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-40}"
ARG SOURCE_IMAGE="aurora"
ARG SOURCE_SUFFIX="-dx"
ARG SOURCE_TAG="latest"

FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}

ARG FEDORA_MAJOR_VERSION

COPY system /
COPY build /tmp/build

## NOTES:
# - /var/lib/alternatives is required to prevent failure with some RPM installs
# - All RUN commands must end with ostree container commit
#   see: https://coreos.github.io/rpm-ostree/container/#using-ostree-container-commit
RUN mkdir -p /var/lib/alternatives && \
  /tmp/build/build.sh && \
  rm -rf /tmp/* /var/* && \
  mkdir -p /var/tmp && \
  chmod -R 1777 /var/tmp && \
  ostree container commit
