#!/usr/bin/env bash

versions=( 13 14 )
for VERSION in "${versions[@]}";
do
  echo "======================================================================="
  echo "BUILDING $VERSION (logs are being saved to build_$VERSION.log)"
  echo "======================================================================="
  docker build -t rwoll/pw-repro:$VERSION --build-arg VERSION=$VERSION . > build_$VERSION.log 2>&1;
  echo "======================================================================="
  echo "TESTING $VERSION"
  echo "======================================================================="
  docker run --init -it --rm --pull=never rwoll/pw-repro:$VERSION
done

echo "======================================================================="
echo "Docker Version"
echo "======================================================================="
docker version
