## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

# Run

## Deploy
```
source .env
forge script script/ZKpaypay.s.sol:ZKpaypayScript --rpc-url ${RPC_URL} --broadcast --verify -vvvv --private-key ${PRIVATE_KEY}
```

```
source .env
forge script script/ERC20.s.sol:SJPYScript --rpc-url ${RPC_URL} --broadcast --verify -vvvv --private-key ${PRIVATE_KEY}
```

## Verify
```
forge verify-contract ${CONTRACT_ADDRESS} --etherscan-api-key ${ETHERSCAN_API_KEY} ./src/ZKpaypay.sol:ZKpaypay --chain 534351
```