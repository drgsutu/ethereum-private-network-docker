# ethereum-private-network-docker
Ethereum private network in Docker containers.
Useful for Ethereum DApp development.


All commands are run from project root dir.

1. Build Docker images:
    ```bash
    ./skipper/build.sh
    ```

2. Start the miner Docker container: 
    ```bash
    ./skipper/run.sh
    ```

3. Attach another geth:
    ```bash
    ./skipper/run-console.sh
    ```


Cleanup containers:
```bash
./skipper/cleanup.sh
```

Cleanup blockchain data:
```bash
./skipper/cleanup-blockchain.sh
```

Connect Mist to the miner:
```bash
mist --rpc ./env/blockchainTestData/local/ethereum/geth.ipc
```
