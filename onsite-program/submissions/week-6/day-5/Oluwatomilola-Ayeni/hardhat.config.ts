import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import { vars } from "hardhat/config";

const PRIVATE_KEY = vars.get("PRIVATE_KEY");
const ETHERSCAN_API_KEY = vars.get("ETHERSCAN_API_KEY");

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {

    liskSepolia: {
      url: "https://rpc.sepolia-api.lisk.com",
      accounts: [PRIVATE_KEY],
      chainId: 4202,
    },

    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/OacryEfQdcKyteO1KT9eP", 
      accounts: [PRIVATE_KEY],
      chainId: 11155111,
    },

  },
  etherscan: {
    apiKey: {

      "lisk-sepolia": "123", 
      sepolia: ETHERSCAN_API_KEY,
    },
    customChains: [

      {
        network: "lisk-sepolia",
        chainId: 4202,
        urls: {
          apiURL: "https://sepolia-blockscout.lisk.com/api",
          browserURL: "https://sepolia-blockscout.lisk.com",
        },
      },
 
    ],
  },
  sourcify: {
    enabled: true, 
  },
};

export default config;