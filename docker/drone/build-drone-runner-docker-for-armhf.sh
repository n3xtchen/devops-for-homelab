#!/bin/bash

docker run -it --name "drone-runner-docker-builder" \
    --volume ${DRONE_RUNNER_DOCKER_SRC:-.}:/work \
    golang:1.20.0-alpine3.17 \
    sh -e -o pipefail -c "cd /work && go env -w GO111MODULE=on && 
    go env -w  GOPROXY=https://goproxy.cn,direct && 
    go build" &
	wait "$!"

docker rm "drone-runner-docker-builder"
