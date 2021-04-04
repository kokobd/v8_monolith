#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"
TAG=$(git describe --tags)
IMAGE_NAME=zelinf/v8_monolith:$TAG
docker build -t $IMAGE_NAME .
