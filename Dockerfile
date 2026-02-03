# syntax=docker/dockerfile:1.2

# Copyright 2021 Authors of Cilium
# SPDX-License-Identifier: Apache-2.0

# BUILDPLATFORM is an automatic platform ARG enabled by Docker BuildKit.
# Represents the plataform where the build is happening, do not mix with
# TARGETARCH
FROM docker.io/library/node:25.5.0-slim@sha256:3393543ad82b7ca5f9329c5115ad801f9e08b4d385f81a616cfb981c32e16c7b
RUN npm install -g json-server@v0.17.4 \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y tini curl iproute2 dnsutils \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Patch and increase node.js default keep alive timeout of 5s to 65s.
#
# Background: Envoy default upstream cluster idle timeout is 60s. If Envoy acts as the "client", this can lead
# race condition where the backend might close TCP connections with a TCP reset (RST) while Envoy wants to use
# that connection (-> HTTP 503). Therefore it's recommended that Envoys keepalive timeout is less than the
# keepalive timeout of the backend.
#
# See https://nodejs.org/api/http.html#http_server_keepalivetimeout
# See https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/core/v3/protocol.proto#envoy-v3-api-field-config-core-v3-httpprotocoloptions-idle-timeout
RUN sed -i "/^  var server = http.createServer(this);/a \  server.keepAliveTimeout = 65000;" /usr/local/lib/node_modules/json-server/node_modules/express/lib/application.js \
    && grep "keepAliveTimeout" /usr/local/lib/node_modules/json-server/node_modules/express/lib/application.js

ADD run.sh default.json middleware.js /
ENTRYPOINT ["bash", "/run.sh"]
CMD []
