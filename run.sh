#!/usr/bin/with-contenv bashio
set -e
cd /
bashio::log.info "🔄 Starting Cloudflare DDNS"

bashio::log.info "📄 Building config.json from Add-on options"
python3 - <<'EOF'
import json
opt = json.load(open('/data/options.json'))
# Reconstruct the exact shape that cloudflare-ddns expects:
cfg = {
    "cloudflare": [
        {
            "authentication": {"api_token": e["api_token"]},
            "zone_id":         e["zone_id"],
            "subdomains":      [{"name": e["name"], "proxied": e["proxied"]}]
        }
        for e in opt.get("cloudflare", [])
    ],
    "a":                  opt.get("a", True),
    "aaaa":               opt.get("aaaa", False),
    "purgeUnknownRecords": opt.get("purgeUnknownRecords", False),
    "ttl":                opt.get("ttl", 300)
}
with open('/config.json','w') as f:
    json.dump(cfg, f, indent=2)
EOF

bashio::log.info "📄 Generated config.json:"

INTERVAL=$(bashio::config 'update_interval')
bashio::log.info "⏱️ Update interval set to ${INTERVAL}s"

# Main loop
while true; do
  bashio::log.info "🚀 Running ddns update"
  python3 cloudflare-ddns.py
  bashio::log.info "💤 Sleeping for ${INTERVAL}s"
  sleep "${INTERVAL}"
done