#!/usr/bin/env bash

cat <<EOF
#############
Hardhat node 
#############
EOF

usage() {
    cat <<EOF
Usage: server [params]
Params:
-s | --start: start docker-compose
-n | --stop: stop docker
-k | --kill: reset image with image name param
EOF
}

killImage() {
    docker images --format="{{.Repository}} {{.ID}}" | 
    grep "^$1 " | 
    cut -d' ' -f2 |
    xargs docker rmi
}

while [ "$1" != "" ]; do
  case $1 in
  -s | --start)
    cd docker &&
    docker-compose up --remove-orphans -d
    exit
    ;;
  -n | --stop)
    cd docker &&
    docker-compose down
    exit
    ;;
  -k | --kill)
    shift
    killImage $1
    exit
    ;;
  -h | --help)
    usage
    exit
    ;;
  esac
  shift
done
