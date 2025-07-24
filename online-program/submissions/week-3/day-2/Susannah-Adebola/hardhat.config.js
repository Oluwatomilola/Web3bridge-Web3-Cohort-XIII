require("@nomicfoundation/hardhat-toolbox");
const {vars} = require("hardhat/config")
//const ETHERSCAN_API_KEY= vars.get("ETHERSCAN_API_KEY")
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  defaultNetwork: "hardhat",
  
  networks:{
    'lisk-sepolia':{
      url: "https://rpc.sepolia-api.lisk.com",
      accounts:vars.has("PRIVATE_KEY")  ? [vars.get("PRIVATE_KEY")] :[],
      chainId: 4202
    }
  },

    etherscan: {
    // Use "123" as a placeholder, because Blockscout doesn't need a real API key, and Hardhat will complain if this property isn't set.
    apiKey: {
      "lisk-sepolia": "123"
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
  sourcify: {
    enabled: false
  },



};

