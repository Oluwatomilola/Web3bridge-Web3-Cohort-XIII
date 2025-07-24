

    require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
const { PRIVATE_KEY, LISK_RPC_URL, LISKSCAN_API_KEY } = process.env;
module.exports = {
  solidity: "0.8.30",
    networks: {
    sepolia: {
      url: LISK_RPC_URL,
      accounts: [`0x${PRIVATE_KEY}`], // Replace with your actual private key
    },
  },
  etherscan: {
    apiKey: {
      sepolia: LISKSCAN_API_KEY,
    },
  },
};