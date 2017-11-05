#!/usr/bin/env bash

set -eu

SERVICE=python-dev-nvidia

if [ "x$(docker-compose ps -q ${SERVICE})" = "x" ]; then
  docker-compose build ${SERVICE}
fi
docker-compose up -d ${SERVICE}
docker exec -i -t `docker-compose ps -q ${SERVICE}` bash --login

exit 0
