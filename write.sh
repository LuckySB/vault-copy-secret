#!/bin/bash
# read from directory

set -x
FROM="$1"
[ -z "$FROM" ] && exit
[ ! -d "$FROM" ] && exit

KV="${2:-$FROM}"

pushd "$FROM"
for k in $(find  -type f); do
  key=${k#.}
  echo $key
  vault kv put -mount "$KV" "${key}" @"${k}"
done

popd
