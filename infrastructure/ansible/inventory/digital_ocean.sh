#!/usr/bin/env bash

set \
  -o nounset \
  -o pipefail \
  -o errexit

tags=$(doctl compute tag list --output json | jq -r '.[].name')
aggregate=$(jq -n '{ "_meta": { "hostvars": { } } }')

for tag in $tags
do
  hosts=$(doctl compute droplet list --tag-name "$tag" --output json | \
    jq '[.[].networks.v4[] | select(.type == "public") | .ip_address]'
  )
  aggregate=$(jq \
    -n \
    --argjson aggregate "$aggregate" \
    --arg tag "$tag" \
    --argjson hosts "$hosts" \
    '$aggregate + { ($tag): $hosts }' \
  )
done
echo "$aggregate"