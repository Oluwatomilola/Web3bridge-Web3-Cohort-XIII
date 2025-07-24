import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

require("dotenv").config();

const PRIVATE_KEY = process.env.PRIVATE_KEY || "";
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY|| "";
const LISK_SEPOLIA_URL = process.env.LISK_SEPOLIA_URL || "";

const config: HardhatUserConfig = {
  solidity: "0.8.30",

  networks: {
   'lisk-sepolia': {
      url: 'https://rpc.sepolia-api.lisk.com',
      accounts: [`0x${PRIVATE_KEY}`],
      gasPrice: 1000000000,
    }
  },
  etherscan: {
    apiKey: {
      "lisk-sepolia": ETHERSCAN_API_KEY
    },
  },
};

export default config;

