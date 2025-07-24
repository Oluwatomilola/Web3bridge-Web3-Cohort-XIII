const { ethers } = require('hardhat');

async function main() {
  const storage = await ethers.deployContract('Storage');

  await storage.waitForDeployment();

  console.log('Storage Contract Deployed at ' + storage.target);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});