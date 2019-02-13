#!/bin/bash

workdir=/opt/check/

echo "$(date -I'seconds') INFO Loading data Traefik API"

URL="${URL:-http://traefik:8080}"

if [ "$CUSTOM_CA" ];
then
  options+=(--cacert $cacert_path)
elif [ "$SKIP_SSL_VERIFICATION" ];
then
   options+=(-k)
fi

if [ "$AUTH_USER" ] && [ "$AUTH_PASSWORD" ];
then
  options+=(-u $AUTH_USER:$AUTH_PASSWORD)
fi

curl -sSL "${options[@]}" $URL/api/providers/docker/frontends  | jq -r ' .[].routes | to_entries[] | .value.rule | gsub("Host:";"https://")' | jq --raw-input --slurp 'split("\n") | [.[] | select( . | length > 0)] | {"data": map_values([.])}' > $workdir/results.json

echo "$(date -I'seconds') INFO Loading data from Traefik API DONE"
