#!/bin/bash

workdir=/opt/check/

echo "$(date -I'seconds') INFO Loading data Traefik API"

URL="${URL:-http://traefik:8080}"
PROVIDER="${PROVIDER:-docker}"

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

curl -sSL "${options[@]}" $URL/api/providers/$PROVIDER/frontends  | jq '{data: map([.routes[].rule | sub("Host:"; "https://") | split(";")[0] ]) | unique | sort}' > $workdir/results.json

echo "$(date -I'seconds') INFO Loading data from Traefik API DONE"
