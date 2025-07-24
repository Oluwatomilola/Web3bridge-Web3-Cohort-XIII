require("@nomicfoundation/hardhat-toolbox");

const { vars } = require("hardhat/config"); // npx hardhat vars set KEYS

const ACCOUNTS = vars.has("PRIVATE_KEY") ? [vars.get("PRIVATE_KEY")] : [];
const ETHERSCAN_API_KEY = vars.has("ETHERSCAN_API_KEY") ? vars.get("ETHERSCAN_API_KEY") : "";
/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: "0.8.28",
  defaultNetwork: "lisk-sepolia",
  networks: {
    'lisk-sepolia': {
      url: 'https://rpc.sepolia-api.lisk.com',
      accounts: ACCOUNTS,
      gasPrice: 1000000000,
    },
  },
  etherscan: {
    apiKey: {
      "lisk-sepolia": "123",
      sepolia: ETHERSCAN_API_KEY,
    },
    customChains: [
      {
          network: "lisk-sepolia",
          chainId: 4202,
          urls: {
              apiURL: "https://sepolia-blockscout.lisk.com/api",
              browserURL: "https://sepolia-blockscout.lisk.com"
          }
      }
    ]
  },
  sourcify: {
    enabled: false
  },
  
};
