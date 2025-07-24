require("@nomicfoundation/hardhat-toolbox");
const { vars } = require("hardhat/config");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  defaultNetwork: "lisk-sepolia",

  networks: {
    "lisk-sepolia": {
      url: "https://rpc.sepolia-api.lisk.com", 
      accounts: vars.has("PRIVATE_KEY") ? [vars.get("PRIVATE_KEY")] : [],
      chainId: 4202, 
      gasPrice: 1000000000, // 1 gwei
    },
  },
  etherscan: {
    apiKey: vars.get("ETHERSCAN_API_KEY"),
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
};
