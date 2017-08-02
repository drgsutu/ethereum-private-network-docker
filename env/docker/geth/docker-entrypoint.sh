#!/bin/sh

set -uo pipefail

keystoreDir='/tmp/.ethereum/keystore'
numberOfAccounts=4

# if command starts with an option, prepend executable /geth
if [ "${1:0:1}" = '-' ]; then
	set -- /geth "$@"
fi

# make sure keystore dir exists
if [ -d "$keystoreDir" ]; then
    mkdir -p ${keystoreDir}
fi

if [ ! "$(ls -A ${keystoreDir})" ]; then
    printf "\n%s\n" "Creating accounts"
    while [ "$numberOfAccounts" -gt 0 ]; do
        /geth --config config.toml account new --password password.txt
        let "numberOfAccounts=numberOfAccounts-1"
    done

    printf "\n%s\n" "Adding accounts to genesis block json"
    for f in $(ls ${keystoreDir}); do
        address=$(jq -r '.address' "$keystoreDir/$f")
        jq --arg address $address '.alloc += {($address):{"balance":"20000000000000000000"}}' customGenesis.json > tmpCustomGenesis.json
        mv tmpCustomGenesis.json customGenesis.json
    done

    printf "\n%s\n" "Initializing genesis block"
    /geth --config config.toml init customGenesis.json
fi

exec "$@"