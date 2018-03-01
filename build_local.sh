#!/usr/bin/env bash
# build_local.sh

echo "Note: To rebuild cache, run: build_local.sh --no-cache"

docker build --tag insync "$@" .
