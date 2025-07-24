import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();
// import { vars } from "hardhat/config";

// const INFURA_API_KEY = vars.get("SEPOLIA_URL_KEY");
// const ETHERSCAN_API_KEY = vars.get("ETHERSCAN_API_KEY");
// const SEPOLIA_PRIVATE_KEY = vars.get("PRIVATE_KEY");

const { PRIVATE_KEY, ETHERSCAN_API_KEY, LISK_URL_KEY } = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.30",
  networks: {
    lisk: {
      url: LISK_URL_KEY,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
};

export default config;