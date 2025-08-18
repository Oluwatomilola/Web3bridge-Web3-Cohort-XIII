import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.18", // Compatible with Uniswap V2
  networks: {
    hardhat: {
      forking: {
        url: "https://mainnet.infura.io/v3/YOUR_INFURA_API_KEY", // Replace with your RPC URL
        blockNumber: 17480237, // Optional: Pin to a recent block (check Etherscan)
      },
      chainId: 1, // Ethereum mainnet chain ID
    },
  },
};

export default config;