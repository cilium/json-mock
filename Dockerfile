# syntax=docker/dockerfile:1.2

# Copyright 2021 Authors of Cilium
# SPDX-License-Identifier: Apache-2.0

# BUILDPLATFORM is an automatic platform ARG enabled by Docker BuildKit.
# Represents the plataform where the build is happening, do not mix with
# TARGETARCH
FROM docker.io/library/node:22.5.0-slim@sha256:70666190c55408e0ea297dc9d4be5d89729d888f4bb720d4b77433c117509cc4
RUN npm install -g json-server@v0.17.4 \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y tini curl iproute2 \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD run.sh default.json middleware.js /
ENTRYPOINT ["bash", "/run.sh"]
CMD []
