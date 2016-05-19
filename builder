#!/bin/sh
# Build wheels for all projects
docker build -t builder -f Dockerfile.build .
mkdir -p wheelhouse
docker run --rm -v "$(pwd)"/wheelhouse:/wheelhouse builder

export TAG=`if [ "$TRAVIS_BRANCH" == "master" ]; then echo "latest"; else echo $THUMBOR_VERSION; fi`

mv wheelhouse thumbor/wheelhouse
docker build -f thumbor/Dockerfile -t apsl/thumbor thumbor/
docker tag apsl/thumbor apsl/thumbor:$TAG
mv thumbor/wheelhouse thumbor-multiprocess/wheelhouse
docker build -f thumbor-multiprocess/Dockerfile -t apsl/thumbor-multiprocess thumbor-multiprocess/
docker tag apsl/thumbor-multiprocess apsl/thumbor-multiprocess:$TAG
docker build -f nginx/Dockerfile -t apsl/thumbor-nginx nginx/
docker tag apsl/thumbor-nginx apsl/thumbor-nginx:$TAG
mv thumbor-multiprocess/wheelhouse remotecv/wheelhouse
docker build -f remotecv/Dockerfile -t apsl/remotecv remotecv/
docker tag apsl/remotecv apsl/remotecv:$TAG
mv remotecv/wheelhouse wheelhouse