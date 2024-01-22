#!/usr/bin/env bash
set -eo pipefail
[ ! -z ${BASH_DEBUG} ] && set -x

docker build \
  -f Dockerfile \
  -t palworld-server:latest \
  .

# do this before docker-compose to avoid dir perm issues
[[ ! -d Saved ]] && mkdir Saved

docker images palworld-server
