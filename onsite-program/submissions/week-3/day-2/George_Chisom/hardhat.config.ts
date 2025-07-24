import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require('dotenv').config();

const { WALLET_KEY, LISK_API_KEY, LISK_URL_KEY } = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.30",
  networks: {
    lisk: {
      url: LISK_URL_KEY,
      accounts: [WALLET_KEY],
    },
  },
  etherscan: {
    apiKey: LISK_API_KEY as string,
  },
};

export default config;
