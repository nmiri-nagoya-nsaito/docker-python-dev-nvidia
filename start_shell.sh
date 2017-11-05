#!/usr/bin/env bash

set -eu

if [ $# -ne 1 ]; then
  echo "start_shell.sh <service_name>"
  echo "available services: python-dev-nvidia"
  exit 1
fi

SERVICE=$1

if [ "x$(docker-compose ps -q ${SERVICE})" = "x" ]; then
  docker-compose pull ${SERVICE}
fi
docker-compose up -d ${SERVICE}
docker exec -i -t `docker-compose ps -q ${SERVICE}` bash --login

exit 0
