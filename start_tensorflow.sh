#!/usr/bin/env bash

set -eu

SERVICE=tensorflow-nv

if [ "x$(docker images -q --filter reference=*/${SERVICE})" = "x" ]; then
  docker-compose pull ${SERVICE}
fi
docker-compose up -d ${SERVICE}

HOME_USER=$(docker exec $(docker-compose ps -q ${SERVICE}) bash -c "eval echo \$\{HOME\}")
docker exec -d `docker-compose ps -q ${SERVICE}` bash -c "source ${HOME_USER}/.profile && jupyter notebook --port=8888 --ip=0.0.0.0 --notebook-dir=/workdir"
docker exec -d `docker-compose ps -q ${SERVICE}` bash -c "source ${HOME_USER}/.profile && tensorboard --logdir=/workdir/tensorboard"
docker-compose ps ${SERVICE}

exit 0
