#!/bin/bash
# save to directory

R="$1"
[ -z "$OLD_VAULT_TOKEN" ] && exit

export VAULT_ADDR=https://old-vault.server.domain
export VAULT_TOKEN="$OLD_VAULT_TOKEN"

set -x
for key in $(vault kv list "$R" | tail -n +3);do
  if [[ $key =~ .*/$ ]]; then
    ./$0 "${R}/${key%/}"
  else
    mkdir -p "${R}"
    vault kv get -format json "${R}/${key}" | jq '.data' > "${R}/${key}"
  fi

done
