#!/usr/bin/env bash

set -e

currentDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
blockchainTestData="${currentDir}/../blockchainTestData/local"

# Cleanup
if docker container inspect geth >& /dev/null; then
    docker container rm --force --volumes geth
fi
docker system prune --force

# Run Geth node
docker container run \
    --interactive \
    --label project=eth-dapp-dev \
    --name geth \
    --rm \
    --tty \
    --user $(id --user):$(id --group) \
    --volume "${blockchainTestData}/ethash":/tmp/.ethash \
    --volume "${blockchainTestData}/ethereum":/tmp/.ethereum \
    drgsutu/ethereum-client-go:alpine --mine --minerthreads=1
