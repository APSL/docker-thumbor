#!/bin/bash
if [ -z "$THUMBOR_VERSION" ]
then
  THUMBOR_VERSION="6.2.0b"
fi

docker network create builder

echo "THUMBOR VERSION: $THUMBOR_VERSION"

echo "--> Wheelhousing requirements in /wheelhouse"
docker build -t test/builder -f Dockerfile.build .
mkdir -p wheelhouse
docker run --rm -v "$(pwd)"/wheelhouse:/wheelhouse test/builder

echo "Launch Pypiserver"
docker run -d --rm --network builder -v "$(pwd)"/wheelhouse:/data/packages --name pypiserver jcsaaddupuy/pypiserver
docker ps -a

echo "--> BUILDING apsl/thumbor"
docker build --network builder -f thumbor/Dockerfile -t apsl/thumbor thumbor/
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
docker build --network builder -f thumbor-multiprocess/Dockerfile -t apsl/thumbor-multiprocess thumbor-multiprocess/
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
docker build --network builder -f remotecv/Dockerfile -t apsl/remotecv remotecv/
echo "--> TAGGING apsl/remotecv:$THUMBOR_VERSION"
docker tag apsl/remotecv apsl/remotecv:$THUMBOR_VERSION
echo "--> TAGGING apsl/remotecv:latest"
docker tag apsl/remotecv apsl/remotecv:latest

echo "--> CLEANUP for pypiserver and builder network"
docker rm -f pypiserver
docker network rm builder
