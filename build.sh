#!/usr/bin/env bash
IMAGE_NAME=lavkesh/cloud-ui
IMAGE_VERSION=$1

DO_NPM_INSTALL=${2:-false}

if [[ "$DO_NPM_INSTALL" == "true" ]]; then
    echo "======================== NPM Install ====================="
    npm install -g gulp bower
    npm install
    echo "======================== Bower Update ====================="
    bower update
fi

echo "======================== Gulp Build ====================="
gulp debug

echo "======================== Start build image ======================="
docker build -t $IMAGE_NAME:$IMAGE_VERSION .
echo "Image build => $IMAGE_NAME:$IMAGE_VERSION"
