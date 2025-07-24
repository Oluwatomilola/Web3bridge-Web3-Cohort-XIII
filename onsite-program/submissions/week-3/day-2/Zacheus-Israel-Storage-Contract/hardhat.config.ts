import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();


const { PRIVATE_KEY, ETHERSCAN_KEY, LISK_SEPOLIA_URL_KEY } = process.env;


const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: {
    lisk: {
      url: LISK_SEPOLIA_URL_KEY,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: {
      sepolia: ETHERSCAN_KEY as string,
    },
  },
};

export default config;
