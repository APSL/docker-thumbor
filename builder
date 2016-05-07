#!/bin/sh
# Build wheels for all projects
docker build -t builder -f Dockerfile.build .
mkdir -p wheelhouse
docker run --rm -v "$(pwd)"/wheelhouse:/wheelhouse builder

mv wheelhouse thumbor/wheelhouse
docker build -f thumbor/Dockerfile -t apsl/thumbor thumbor/
mv thumbor/wheelhouse thumbor-multiprocess/wheelhouse
docker build -f thumbor-multiprocess/Dockerfile -t apsl/thumbor-multiprocess thumbor-multiprocess/
docker build -f nginx/Dockerfile -t apsl/thumbor-nginx nginx/
mv thumbor-multiprocess/wheelhouse remotecv/wheelhouse
docker build -f remotecv/Dockerfile -t apsl/remotecv remotecv/
mv remotecv/wheelhouse wheelhouse