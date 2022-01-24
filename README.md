### A local environment for developing with Chainlink 

Develop with Chainlink on your locally forked ganache chain. Allows you to work with instant transactions and unlocked accounts, including the node's address. Only works with infura endpoints for now.

### How to use it:

1. Start both ganache and postgresql with `./start.sh` script.
2. Move to `chainlink/` folder and configure `.api`, `.env` and `.password` files.
3. Start your node with `./run.sh`
4. Note your node's address and replace it in `start.sh` script
5. In subsequent startups, make sure to sync the node's transaction nonces before making any transactions with the node (number of transactions done to now) with ganache nonce (set at 0). You can use the `pychainlink` package in this git to this end.

Always good to check:
- Properly fund your node with `LINK` and/or `ETH` before making any transaction
- Properly fund your consumer contract with `LINK` before making any transactions
- Double check that your oracle contract is in line with what is expected for your job
