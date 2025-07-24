require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config(); // To load your PRIVATE_KEY from .env

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    liskSepolia: {
      url: "https://rpc.sepolia-api.lisk.com", 
      accounts: [process.env.PRIVATE_KEY],     
    },
  },
};