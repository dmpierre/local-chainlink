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

### How to sync your node's nonce with your ganache chain?

When you stop and re-start a ganache chain your node address' nonce will be reset at 0. It will make you unable to process any transactions. In this case you have two choices:
1. Reset the node's postgresql db
2. Update the node's address nonce

The first solution does not require your node's account to be unlocked but is *very* cumbersome as it will change the node's adress and erase all the jobs you configured

Because we have access to the node's address, you simply have to make sure that its address is unlocked when starting your ganache chain (see `.env` file, used when starting ganache). Having the unlocked node's address, makes you able to simply update its nonce before interacting with it.

Using the `pychainlink` package in this project:

```python
host_ganache = "ws://localhost:8545"
node_address = "0x3EbcB76E39Dd4f3A01a4dAa396F7186726F3A9Ac"
host_postgresql = "localhost"
database = "chainlinknode" # default values set in postgresql/Dockerfile
user = "chainlinknode" # default values set in postgresql/Dockerfile
password = "chainlinknode" # default values set in postgresql/Dockerfile

# init connections to ganache and node's database
w3 = Web3(Web3.WebsocketProvider(host_ganache))
nodedb_connection = nodedb.NodeDB(host_postgresql, database, user, password)

# fund node with ETH beforehand
_ = w3.eth.send_transaction({"from": w3.eth.accounts[0], "to": node_address, "value": w3.toWei(10, unit="ether")})

# carry out arbitrary transactions to sync ganache node address nonce with node 
nonce_sync_transactions = manage.sync_node_nonce(w3, nodedb_connection, node_address)
```

It will carry out the correct number of transactions needed to have a correct nonce set up:

```
Expected transactions count: 0, node transactions count: 8
Carrying out 8 transaction(s)...
```

And you will have:
```python
nonce_sync_transactions

[HexBytes('0x68d768a8eb04b288f6e4fb777e1b23ee3650c79866921567fcf04c4674bb3fe9'),
 HexBytes('0xa94453a4a3f4fc85f8035e8ce3f01e33041b17b5b9be128d913503c8915818d5'),
 HexBytes('0x2c0d9b0c49014fc96939a664fb6910daa2254bf8dcd92fb6671b83e93f3e1a9e'),
 HexBytes('0x14ebebc84aa711262ffdb2da47f7da4bd2b597c0f4a09258c3d91cd4c686ff74'),
 HexBytes('0xccb88f27ff41badbf26bc8010de834f04e6fb87bf1b0ef46f49af722eff53887'),
 HexBytes('0x96e8eea8d7a77d0b7371cafc3146765c2a0ccfcde37d4144b9e0779ca7207d1a'),
 HexBytes('0xa078438b785fce655307362d0ec87c04f2d96975c97ca51fb74f18384727e26f'),
 HexBytes('0x0740396b597ed2e7b0f7d634d9b6120dbe6be3ed059fed59c9c8fa55e34de1dc')]
```