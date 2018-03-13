#!/bin/bash
if [ -z "$THUMBOR_VERSION" ]
then
  THUMBOR_VERSION="6.4.0"
fi

echo "THUMBOR VERSION: $THUMBOR_VERSION"

echo "--> Wheelhousing requirements in /wheelhouse"
docker build -t test/builder -f Dockerfile.build .
mkdir -p wheelhouse
docker run --rm -v "$(pwd)"/wheelhouse:/wheelhouse test/builder

echo "Launch Pypiserver"
docker-compose -f docker-compose-travis.yml up -d pypiserver 
docker ps -a

#export DOCKERHOST="docker.for.mac.host.internal" # For building on OSX
export DOCKERHOST=$(ip route | awk '/docker/ { print $NF }')

echo "--> BUILDING apsl/thumbor"
docker build --build-arg DOCKERHOST=$DOCKERHOST -f thumbor/Dockerfile -t apsl/thumbor thumbor/
echo "--> TAGGING apsl/thumbor:$THUMBOR_VERSION"
docker tag apsl/thumbor apsl/thumbor:$THUMBOR_VERSION
echo "--> TAGGING apsl/thumbor:latest"
docker tag apsl/thumbor apsl/thumbor:latest

echo "--> BUILDING apsl/thumbor:simd-sse4"
docker build --build-arg SIMD_LEVEL=sse4  -f thumbor-simd/Dockerfile -t apsl/thumbor-simd-sse4 thumbor-simd/
echo "--> TAGGING apsl/thumbor:$THUMBOR_VERSION-simd-sse4"
docker tag apsl/thumbor-simd-sse4 apsl/thumbor:$THUMBOR_VERSION-simd-sse4
echo "--> TAGGING apsl/thumbor:latest-simd-sse4"
docker tag apsl/thumbor-simd-sse4 apsl/thumbor:latest-simd-sse4

echo "--> BUILDING apsl/thumbor:simd-avx2"
docker build --build-arg SIMD_LEVEL=avx2  -f thumbor-simd/Dockerfile -t apsl/thumbor-simd-avx2 thumbor-simd/
echo "--> TAGGING apsl/thumbor:$THUMBOR_VERSION-simd-avx2"
docker tag apsl/thumbor-simd-avx2 apsl/thumbor:$THUMBOR_VERSION-simd-avx2
echo "--> TAGGING apsl/thumbor:latest-simd-avx2"
docker tag apsl/thumbor-simd-avx2 apsl/thumbor:latest-simd-avx2

echo "--> BUILDING apsl/thumbor-multiprocess"
docker build --build-arg DOCKERHOST=$DOCKERHOST -f thumbor-multiprocess/Dockerfile -t apsl/thumbor-multiprocess thumbor-multiprocess/
echo "--> TAGGING apsl/thumbor-multiprocess:$THUMBOR_VERSION"
docker tag apsl/thumbor-multiprocess apsl/thumbor-multiprocess:$THUMBOR_VERSION
echo "--> TAGGING apsl/thumbor-multiprocess:latest"
docker tag apsl/thumbor-multiprocess apsl/thumbor-multiprocess:latest

echo "--> BUILDING apsl/thumbor-multiprocess:simd-sse4"
docker build --build-arg SIMD_LEVEL=sse4 -f thumbor-multiprocess-simd/Dockerfile -t apsl/thumbor-multiprocess-simd-sse4 thumbor-multiprocess-simd/
echo "--> TAGGING apsl/thumbor-multiprocess:$THUMBOR_VERSION-simd-sse4"
docker tag apsl/thumbor-multiprocess-simd-sse4 apsl/thumbor-multiprocess:$THUMBOR_VERSION-simd-sse4
echo "--> TAGGING apsl/thumbor-multiprocess:latest-simd-sse4"
docker tag apsl/thumbor-multiprocess-simd-sse4 apsl/thumbor-multiprocess:latest-simd-sse4

echo "--> BUILDING apsl/thumbor-multiprocess:simd-avx2"
docker build --build-arg SIMD_LEVEL=avx2 -f thumbor-multiprocess-simd/Dockerfile -t apsl/thumbor-multiprocess-simd-avx2 thumbor-multiprocess-simd/
echo "--> TAGGING apsl/thumbor-multiprocess:$THUMBOR_VERSION-simd-avx2"
docker tag apsl/thumbor-multiprocess-simd-avx2 apsl/thumbor-multiprocess:$THUMBOR_VERSION-simd-avx2
echo "--> TAGGING apsl/thumbor-multiprocess:latest-simd-avx2"
docker tag apsl/thumbor-multiprocess-simd-avx2 apsl/thumbor-multiprocess:latest-simd-avx2

echo "--> BUILDING apsl/thumbor-nginx"
docker build -f nginx/Dockerfile -t apsl/thumbor-nginx nginx/
echo "--> TAGGING apsl/thumbor-nginx:$THUMBOR_VERSION"
docker tag apsl/thumbor-nginx apsl/thumbor-nginx:$THUMBOR_VERSION
echo "--> TAGGING apsl/thumbor-nginx:latest"
docker tag apsl/thumbor-nginx apsl/thumbor-nginx:latest

echo "--> BUILDING apsl/remotecv"
docker build --build-arg DOCKERHOST=$DOCKERHOST -f remotecv/Dockerfile -t apsl/remotecv remotecv/
echo "--> TAGGING apsl/remotecv:$THUMBOR_VERSION"
docker tag apsl/remotecv apsl/remotecv:$THUMBOR_VERSION
echo "--> TAGGING apsl/remotecv:latest"
docker tag apsl/remotecv apsl/remotecv:latest

