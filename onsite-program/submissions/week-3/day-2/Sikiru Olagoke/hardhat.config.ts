import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();

const { LISK_RPC_URL, PRIVATE_KEY } = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.23",
  networks: {
    // for testnet
    "lisk-sepolia": {
      url: LISK_RPC_URL,
      accounts: [PRIVATE_KEY as string],
      gasPrice: 1000000000,
    },
  },
};

export default config;
