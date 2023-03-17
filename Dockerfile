# syntax=docker/dockerfile:1.2

# Copyright 2021 Authors of Cilium
# SPDX-License-Identifier: Apache-2.0

# BUILDPLATFORM is an automatic platform ARG enabled by Docker BuildKit.
# Represents the plataform where the build is happening, do not mix with
# TARGETARCH
FROM docker.io/library/node:19.8.1-slim@sha256:f5eb5c04eeb0bdaff44e179b84b57b8958f2fc6fb814641d3a5f3fe27d93e248
RUN npm install -g json-server \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD run.sh default.json auth-header.js /
ENTRYPOINT ["bash", "/run.sh"]
CMD []
