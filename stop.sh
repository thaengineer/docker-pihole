#!/usr/bin/env bash

echo "Stopping Pi-hole container..."
docker kill pihole &> /dev/null
