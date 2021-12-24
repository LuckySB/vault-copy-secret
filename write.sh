#!/bin/bash
# read from directory

set -x
FROM="$1"
[ -z "$FROM" ] && exit
[ ! -d "$FROM" ] && exit

KV="${2:-$FROM}"

pushd "$FROM"
for k in $(find  -type f); do
  key=${KV}${k#.}
  echo $key
  vault write "${key}" @"${k}"
done

popd
