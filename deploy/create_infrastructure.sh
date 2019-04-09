#!/usr/bin/env bash

set \
  -o nounset \
  -o pipefail \
  -o errexit \
  -o verbose \
  -o xtrace

# create server
DROPLET_ID=$(
  doctl compute droplet create rocdev-v2 \
    --wait \
    --region nyc1 \
    --image ubuntu-18-04-x64 \
    --size s-1vcpu-1gb \
    --user-data-file user-data.yml \
    --output json \
  | \
  jq -r '.[0].id'
)

# firewall egress to dns
doctl compute firewall create \
  --name rocdev-common-egress \
  --droplet-ids "$DROPLET_ID" \
  --outbound-rules 'protocol:udp,ports:53,address:0.0.0.0/0 protocol:udp,ports:53,address:::/0 protocol:tcp,ports:80,address:0.0.0.0/0 protocol:tcp,ports:80,address:::/0 protocol:tcp,ports:443,address:0.0.0.0/0 protocol:tcp,ports:443,address:::/0'

# firewall ingress port 80 and 443 from anywhere
doctl compute firewall create \
  --name rocdev-web-ingress \
  --droplet-ids "$DROPLET_ID" \
  --inbound-rules "protocol:tcp,ports:80,address:0.0.0.0/0 protocol:tcp,ports:443,address:0.0.0.0/0 protocol:tcp,ports:80,address:::/0 protocol:tcp,ports:443,address:::/0"
# firewall ingress port 22 from known ips
doctl compute firewall create \
  --name rocdev-ssh-ingress \
  --droplet-ids "$DROPLET_ID" \
  --inbound-rules protocol:tcp,ports:22,address:"$(curl 'https://postman-echo.com/ip' 2>/dev/null | jq -r '.ip')"
