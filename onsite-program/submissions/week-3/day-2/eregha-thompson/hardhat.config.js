require("@nomicfoundation/hardhat-toolbox");

require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
const {PRIVATE_KEY, ETHERSCAN_API_KEY, LISK_URL_KEY} = process.env;

module.exports = {
  solidity: "0.8.30",
  networks: {
    liskTestnet: {
      url: LISK_URL_KEY,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: {
      lisk: ETHERSCAN_API_KEY,
    },
  },
};
