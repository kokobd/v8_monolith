#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
TAG=$(git describe --tags)
IMAGE_NAME=zelinf/v8_monolith:builder-$TAG
docker build -t $IMAGE_NAME --build-arg TAG=$TAG .
CONTAINER_ID=$(docker run -d -it $IMAGE_NAME /bin/bash)
rm -rf output
mkdir output
docker cp $CONTAINER_ID:/work/v8/out output/out
docker cp $CONTAINER_ID:/work/v8/include output/include
docker container rm -f $CONTAINER_ID

cd output/out
for libdir in *; do
  mkdir -p ../$libdir/lib
  cp $libdir/obj/libv8_monolith.a ../$libdir/lib/libv8_monolith.a
  cp -r ../include ../$libdir/include
done
cd ..
rm -rf include out

for libdir in *; do
  mv $libdir v8_monolith-$libdir
  tar czf v8_monolith-$libdir.tar.gz v8_monolith-$libdir
  rm -rf v8_monolith-$libdir
done