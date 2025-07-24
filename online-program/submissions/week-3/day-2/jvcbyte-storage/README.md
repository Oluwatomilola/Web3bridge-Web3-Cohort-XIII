# Storage Contract Hardhat Project

This project demonstrates a basic Hardhat workflow for deploying and testing a simple `Storage` smart contract using Hardhat Ignition. It includes:

- The `Storage.sol` contract
- Automated tests for the contract
- Hardhat Ignition deployment modules

## Project Structure

- `contracts/Storage.sol` - The Storage contract source code
- `test/Storage.ts` - Tests for the Storage contract
- `ignition/modules/Storage.ts` - Ignition deployment module for Storage
- `hardhat.config.js` - Hardhat configuration

## How to Use

### Install Dependencies

```bash
npm install
```

### Compile Contracts

```bash
npx hardhat compile
```

### Run Tests

```bash
npx hardhat test
```

### Deploy to Lisk Sepolia

Make sure your `.env` file contains the correct private key and API keys for Lisk Sepolia.

```bash
npx hardhat ignition deploy ./ignition/modules/Storage.ts --network lisk-sepolia --deployment-id sepolia-deployment
```

## Contract Address

Deployed Storage contract address (Lisk Sepolia):

```
0x19B94b60A77D19ee9c9C46604c5af52e830D8110
```

Replace `<CONTRACT_ADDRESS_HERE>` with your actual deployed contract address after deployment.

## Example Usage

You can interact with the deployed contract using Hardhat scripts or directly via Etherscan/Blockscout for Lisk Sepolia.

### Store a Value

```js
await storage.store(42);
```

### Retrieve a Value

```js
const value = await storage.retrieve();
```

## Environment Variables

Create a `.env` file in the project root with the following variables:

```
PRIVATE_KEY_1=your_private_key
TEST_API_KEY=your_alchemy_or_rpc_api_key
LISK_SCAN_API_KEY=your_lisk_sepolia_explorer_api_key
```

## License

MIT
