#!/bin/bash

PIHOLE_BASE="$(pwd)/pihole"
[[ -d ${PIHOLE_BASE} ]] || mkdir -p ${PIHOLE_BASE} || { echo "Unable to create storage directory: ${PIHOLE_BASE}"; exit 1 }

docker run --rm -d \
-p 53:53/tcp \
-p 53:53/udp \
-p 80:80 \
-p 443:443 \
-v $(pwd)/etc-pihole:/etc/pihole \
-v $(pwd)/etc-dnsmask.d:/etc/dnsmask.d \
-e TZ="America/New_York" \
--dns=127.0.0.1 \
--dns=1.1.1.1 \
--h ad.blocker.com \
--name pihole \
pihole/pihole:latest \
&& echo "Pihole administration console: http://127.0.0.1/admin/" \
&& echo "Password: $(docker logs b6f5429d2eda 2> /dev/null | grep "Setting password:" | awk '{ print $3 }')"
