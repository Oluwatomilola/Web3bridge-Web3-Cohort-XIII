import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config()

const {PRIVATE_KEY, ETHERSCAN_API_KEY, LISK_SEPOLIA_URL} = process.env;
const sep = String(ETHERSCAN_API_KEY)

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
    apiKey: ETHERSCAN_API_KEY
  },
};

export default config;
