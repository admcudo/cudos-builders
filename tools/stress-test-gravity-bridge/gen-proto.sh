#!/usr/bin/env bash


proto_dirs=$(find ./cudos-to-eth/cosmos/proto -path -prune -o -name '*.proto' -print0 | xargs -0 -n1 dirname | sort | uniq)
proto_files=()

for dir in $proto_dirs; do
  proto_files=("${proto_files[@]} $(find "${dir}" -maxdepth 1 -name '*.proto')")
done

npx pbjs \
  -o ./cudos-to-eth/cosmos/proto.cjs \
  -t static-module \
  --force-long \
  --keep-case \
  --no-create \
  --path=./proto/ \
  --path=./proto-thirdparty/ \
  --root="@cosmos-client/core" \
  ${proto_files[@]}

npx pbjs \
  -o ./cudos-to-eth/cosmos/proto.js \
  -t static-module \
  -w es6 \
  --es6 \
  --force-long \
  --keep-case \
  --no-create \
  --path=./proto/ \
  --path=./proto-thirdparty/ \
  --root="@cosmos-client/core" \
  ${proto_files[@]}

npx pbts \
  -o ./cudos-to-eth/cosmos/proto.d.ts \
  ./cudos-to-eth/cosmos/proto.js