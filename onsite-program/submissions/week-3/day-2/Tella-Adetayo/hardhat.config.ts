import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv"; 

dotenv.configDotenv(); 

const { PRIVATE_KEY, LISK_RPC_URL, ETHERSCAN_KEY } = process.env; 

const config: HardhatUserConfig = {
  solidity: "0.8.30",
  networks: {
    sepolia: {
      url: LISK_RPC_URL, 
      accounts: [`0x${PRIVATE_KEY}`], 
    }, 
  }, 
  etherscan: {
    apiKey: ETHERSCAN_KEY
  }
};

export default config;
