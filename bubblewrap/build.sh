#1/usr/bin/env bash
set -euo pipefail

imagename=bwrap-build-result
docker build -t "$imagename" .
id="$(docker create "$imagename")"
docker cp "$id:/bwrap" .

# Cleanup
docker rm -v "$id"
docker rmi "$imagename"
