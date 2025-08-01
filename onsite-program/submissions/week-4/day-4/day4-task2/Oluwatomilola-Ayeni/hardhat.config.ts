// import { HardhatUserConfig } from "hardhat/config";
// import "@nomicfoundation/hardhat-toolbox";

// const config: HardhatUserConfig = {
//   solidity: "0.8.28",
// };

// export default config;

// hardhat.config.ts  SEPOLIA_RPC_URL
import { HardhatUserConfig, vars } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

// Get variables using hardhat vars
const SEPOLIA_RPC_URL = vars.get("SEPOLIA_RPC_URL");
const PRIVATE_KEY = vars.get("PRIVATE_KEY", "");
// const ETHERSCAN_API_KEY = vars.get("ETHERSCAN_API_KEY");

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: SEPOLIA_RPC_URL,
      accounts: PRIVATE_KEY ? [PRIVATE_KEY] : [],
      chainId: 11155111,
    },
    'lisk-sepolia': {
      url: 'https://rpc.sepolia-api.lisk.com',
      accounts: [PRIVATE_KEY as string],
      gasPrice: 1000000000,
    }
  },
  gasReporter: {
    enabled: process.env.REPORT_GAS !== undefined,
    currency: "USD",
  },
  etherscan: {
    apiKey: {
      "lisk-sepolia": "123", 
    }, 
    
    customChains: [
      {
          network: "lisk-sepolia",
          chainId: 4202,
          urls: {
              apiURL: "https://sepolia-blockscout.lisk.com/api",
              browserURL: "https://sepolia-blockscout.lisk.com"
          }
      }
    ]
      
  },
  
  ignition: {
    requiredConfirmations: 1,
  },
  sourcify: {
    enabled: false
}
};

export default config;
// ETHERSCAN_API_KEY
