#!/bin/bash

# # Build wheels for all projects
# export TAG=`if [ "$TRAVIS_BRANCH" == "master" ]; then echo "latest"; else echo $THUMBOR_VERSION; fi`
# echo "TAG: $TAG"
# echo "TRAVIS_BRANCH: $TRAVIS_BRANCH"
# echo "THUMBOR_VERSION: $THUMBOR_VERSION"

docker build -t builder -f Dockerfile.build .
mkdir -p wheelhouse
docker run --rm -v "$(pwd)"/wheelhouse:/wheelhouse builder

mv wheelhouse thumbor/wheelhouse
echo "--> BUILDING apsl/thumbor"
docker build -f thumbor/Dockerfile -t apsl/thumbor thumbor/
echo "--> TAGGING apsl/thumbor:$THUMBOR_VERSION"
docker tag apsl/thumbor apsl/thumbor:$THUMBOR_VERSION
mv thumbor/wheelhouse thumbor-multiprocess/wheelhouse
echo "--> BUILDING apsl/thumbor-multiprocess"
docker build -f thumbor-multiprocess/Dockerfile -t apsl/thumbor-multiprocess thumbor-multiprocess/
echo "--> TAGGING apsl/thumbor-multiprocess:$THUMBOR_VERSION"
docker tag apsl/thumbor-multiprocess apsl/thumbor-multiprocess:$THUMBOR_VERSION
echo "--> BUILDING apsl/thumbor-nginx"
docker build -f nginx/Dockerfile -t apsl/thumbor-nginx nginx/
echo "--> TAGGING apsl/thumbor-nginx:$THUMBOR_VERSION"
docker tag apsl/thumbor-nginx apsl/thumbor-nginx:$THUMBOR_VERSION
mv thumbor-multiprocess/wheelhouse remotecv/wheelhouse
echo "--> BUILDING apsl/remotecv"
docker build -f remotecv/Dockerfile -t apsl/remotecv remotecv/
echo "--> TAGGING apsl/remotecv:$THUMBOR_VERSION"
docker tag apsl/remotecv apsl/remotecv:$THUMBOR_VERSION
mv remotecv/wheelhouse wheelhouse
if [ "$TRAVIS_BRANCH" == "master" ];
then 
  docker tag apsl/thumbor apsl/thumbor:latest
  docker tag apsl/thumbor-multiprocess apsl/thumbor-multiprocess:latest
  docker tag apsl/thumbor-nginx apsl/thumbor-nginx:latest
  docker tag apsl/remotecv apsl/remotecv:latest
fi