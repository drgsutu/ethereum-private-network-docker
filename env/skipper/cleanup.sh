#!/usr/bin/env bash

docker container ps \
    --all \
    --filter label=project=eth-dapp-dev \
    --quiet | xargs --no-run-if-empty docker container rm --force --volumes

docker network ls \
    --filter label=project=eth-dapp-dev \
    --quiet | xargs --no-run-if-empty docker network rm
