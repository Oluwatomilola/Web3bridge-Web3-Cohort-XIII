import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";

dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: {
    lisk: {
      url: "https://lisk-sepolia.drpc.org",
      chainId: 4202,
      accounts: [process.env.PRIVATE_KEY!],
    },
  },
  etherscan: {
    // Your API key for Blockscout
    // It is recommended to store this in your .env file
    apiKey: {
      lisk: '1234',
    },
    customChains: [
      {
        network: "lisk",
        chainId: 4202,
        urls: {
          apiURL: "https://sepolia-blockscout.lisk.com/api",
          browserURL: "https://sepolia-blockscout.lisk.com",
        },
      },
    ],
  },
};

export default config;
