# Proactive Refresh Contracts

Smart contracts submitted as part of the [Proactive Refresh](https://devpost.com/software/proactive-refresh) project for [TreeHacks 2023](https://www.treehacks.com/). Contracts are mostly based on Gnosis Safe but have modified signature validation logic and incorporate some Zetachain corss-chain features.

See https://github.com/lyronctk/proactive-refresh for more details.

## Deployments

Zetachain GnosisSafeL2: [0x70441FDBab4D5521FbcF4A62F7c9023eE88CA70D](https://explorer.zetachain.com/address/0x70441FDBab4D5521FbcF4A62F7c9023eE88CA70D)

Goerli GnosisSafeL2: [0xf2d48C7F6ff69b487f277BC011D853577c3880eb](https://goerli.etherscan.io/address/0xf2d48C7F6ff69b487f277BC011D853577c3880eb)

Goerli GnosisSafeZetachainClient: [0x34e2cD2967BBe834a41DdE368Ad2b239d765f378](https://goerli.etherscan.io/address/0x34e2cD2967BBe834a41DdE368Ad2b239d765f378)

## Usage

### Install requirements with yarn:

```bash
yarn
```

### Run all tests:

```bash
yarn build
yarn test
```

### Deployments

A collection of the different Safe contract deployments and their addresses can be found in the [Safe deployments](https://github.com/gnosis/safe-deployments) repository.

To add support for a new network follow the steps of the `Deploy` section and create a PR in the [Safe deployments](https://github.com/gnosis/safe-deployments) repository.

### Deploy

> :warning: **Make sure to use the correct commit when deploying the contracts.** Any change (even comments) within the contract files will result in different addresses. The tagged versions that are used by the Gnosis Safe team can be found in the [releases](https://github.com/gnosis/safe-contracts/releases).

This will deploy the contracts deterministically and verify the contracts on etherscan using [Solidity 0.7.6](https://github.com/ethereum/solidity/releases/tag/v0.7.6) by default.

Preparation:

- Set `MNEMONIC` in `.env`
- Set `INFURA_KEY` in `.env`

```bash
yarn deploy-all <network>
```

This will perform the following steps

```bash
yarn build
yarn hardhat --network <network> deploy
yarn hardhat --network <network> etherscan-verify
yarn hardhat --network <network> local-verify
```

#### Custom Networks

It is possible to use the `NODE_URL` env var to connect to any EVM based network via an RPC endpoint. This connection then can be used with the `custom` network.

E.g. to deploy the Safe contract suite on that network you would run `yarn deploy-all custom`.

The resulting addresses should be on all networks the same.

Note: Address will vary if contract code is changed or a different Solidity version is used.

#### Replay protection (EIP-155)

Some networks require replay protection. This is not possible with the default deployment process as it relies on a presigned transaction without replay protection (see https://github.com/Arachnid/deterministic-deployment-proxy).

It is possible to enable deployment via a different determinisitic deployment proxy (https://github.com/gnosis/safe-singleton-factory). To enable this the `CUSTOM_DETERMINISTIC_DEPLOYMENT` env var has to be set to `true` (see `.env.sample`). To make sure that the latest version of this package is install, make sure to run `yarn add @gnosis.pm/safe-singleton-factory` before deployment.

Note: This will result in different addresses compared to the default deployment process.

### Verify contract

This command will use the deployment artifacts to compile the contracts and compare them to the onchain code

```bash
yarn hardhat --network <network> local-verify
```

This command will upload the contract source to Etherescan

```bash
yarn hardhat --network <network> etherscan-verify
```

## Documentation

- [Safe developer portal](http://docs.gnosis.io/safe)
- [Error codes](docs/error_codes.md)
- [Coding guidelines](docs/guidelines.md)

## Audits/ Formal Verification

This fork is unaudited; use at yur own risk.

## Security and Liability

All contracts are WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

## License

All smart contracts are released under LGPL-3.0
