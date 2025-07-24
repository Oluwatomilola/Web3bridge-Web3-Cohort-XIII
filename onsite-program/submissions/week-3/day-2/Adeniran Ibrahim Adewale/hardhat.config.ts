import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

require("dotenv").config();

const {PRIVATE_KEY, ETHERSCAN_KEY, LISK_URL_KEY } = process.env

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  networks: {
    lisk: {
      url: LISK_URL_KEY,
      accounts: [`0x${PRIVATE_KEY}`]
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_KEY,
  },  
};

export default config;
