#!/bin/bash

set -x

docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD

docker build . -t zekro/gmod-ttt:latest
docker push zekro/gmod-ttt
