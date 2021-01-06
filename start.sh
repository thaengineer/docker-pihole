#!/usr/bin/env bash

PIHOLE_BASE="$(pwd)/pihole"
PIHOLE_PASS='!QAZ2wsx'
[[ ! -d ${PIHOLE_BASE} ]] && mkdir -p ${PIHOLE_BASE}

echo -e "Starting Pi-hole container...\n"

docker run --rm -d \
-p 53:53/tcp \
-p 53:53/udp \
-p 80:80 \
-p 443:443 \
-v ${PIHOLE_BASE}/etc-pihole:/etc/pihole \
-v ${PIHOLE_BASE}/etc-dnsmask.d:/etc/dnsmask.d \
-e TZ="America/New_York" \
--dns=127.0.0.1 \
--dns=1.1.1.1 \
-h ad.blocker.com \
--name pihole \
pihole/pihole:latest

while [[ "$(docker inspect -f "{{.State.Health.Status}}" pihole)" != "healthy" ]]; do
  sleep 1
done

docker exec pihole pihole -a -p ${PIHOLE_PASS}

echo -e "\nPihole administration console: http://127.0.0.1/admin/"
echo "Password: ${PIHOLE_PASS}"
