#!/bin/bash

echo "--> Wheelhousing requirements in /wheelhouse"
docker build -t test/builder -f Dockerfile.build .
mkdir -p wheelhouse
docker run --rm -v "$(pwd)"/wheelhouse:/wheelhouse test/builder

echo "Launch Pypiserver"
docker-compose -f docker-compose-travis.yml up -d pypiserver 
docker ps -a

export DOCKERHOST=$(ip route | awk '/docker/ { print $NF }')

echo "--> BUILDING apsl/thumbor"
docker build --build-arg DOCKERHOST=$DOCKERHOST -f thumbor/Dockerfile -t apsl/thumbor thumbor/
echo "--> TAGGING apsl/thumbor:$THUMBOR_VERSION"
docker tag apsl/thumbor apsl/thumbor:$THUMBOR_VERSION
docker tag apsl/thumbor apsl/thumbor:latest

echo "--> BUILDING apsl/thumbor-multiprocess"
docker build --build-arg DOCKERHOST=$DOCKERHOST -f thumbor-multiprocess/Dockerfile -t apsl/thumbor-multiprocess thumbor-multiprocess/
echo "--> TAGGING apsl/thumbor-multiprocess:$THUMBOR_VERSION"
docker tag apsl/thumbor-multiprocess apsl/thumbor-multiprocess:$THUMBOR_VERSION
docker tag apsl/thumbor-multiprocess apsl/thumbor-multiprocess:latest

echo "--> BUILDING apsl/thumbor-nginx"
docker build -f nginx/Dockerfile -t apsl/thumbor-nginx nginx/
echo "--> TAGGING apsl/thumbor-nginx:$THUMBOR_VERSION"
docker tag apsl/thumbor-nginx apsl/thumbor-nginx:$THUMBOR_VERSION
docker tag apsl/thumbor-nginx apsl/thumbor-nginx:latest

echo "--> BUILDING apsl/remotecv"
docker build --build-arg DOCKERHOST=$DOCKERHOST -f remotecv/Dockerfile -t apsl/remotecv remotecv/
echo "--> TAGGING apsl/remotecv:$THUMBOR_VERSION"
docker tag apsl/remotecv apsl/remotecv:$THUMBOR_VERSION
docker tag apsl/remotecv apsl/remotecv:latest
