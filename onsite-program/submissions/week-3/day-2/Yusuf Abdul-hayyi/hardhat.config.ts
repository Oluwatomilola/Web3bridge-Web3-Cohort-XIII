import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();

const { SEPOLIA_URL_KEY, ETHERSCAN_API_KEY, PRIVATE_KEY } = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: { 
    'lisk-sepolia': {
      url: SEPOLIA_URL_KEY,
      accounts: [`0x${PRIVATE_KEY}`]
    }, 
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  }
};


export default config;
