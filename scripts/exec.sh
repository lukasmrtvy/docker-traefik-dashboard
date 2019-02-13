#!/bin/bash

workdir=/opt/check/

echo "$(date -I'seconds') INFO Loading data Traefik API"

URL="${URL:-http://traefik:8080}"

if [ $CUSTOM_CA ];
then
  options+=(--cacert $cacert_path)
fi

if [ $SKIP_SSL_VERIFICATION ];
then
  options+=(-k)
fi

if [ $AUTH_USER ] && [ $AUTH_PASSWORD ];
then
  options+=(-u $AUTH_USER:$AUTH_PASSWORD)
fi

curl -sSL "${options[@]}" $URL/api/providers/docker/frontends  | jq -r ' .[].routes | to_entries[] | .value.rule | gsub("Host:";"https://")' -o $workdir/results.json > /dev/null 2>&1

echo "$(date -I'seconds') INFO Loading data from Traefik API DONE"

