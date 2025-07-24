import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config()

const {PRIVATE_KEY, ETHERSCAN_KEY, LISK_SEPOLIA_URL} = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.28",

  networks: {
     // for testnet
    'lisk-sepolia': {
      url: LISK_SEPOLIA_URL,
      accounts: [PRIVATE_KEY as string],
      gasPrice: 1000000000,
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_KEY
  },
};

export default config;