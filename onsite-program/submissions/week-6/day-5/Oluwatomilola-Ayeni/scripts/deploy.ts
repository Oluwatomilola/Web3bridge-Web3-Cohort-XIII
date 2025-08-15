import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  
  console.log("Deploying contracts with the account:", deployer.address);
  console.log("Account balance:", (await deployer.provider?.getBalance(deployer.address))?.toString());

  // Deploy contract
  const TimeNFT = await ethers.getContractFactory("TimeNFT");
  const timeNFT = await TimeNFT.deploy();
  await timeNFT.waitForDeployment();

  const contractAddress = await timeNFT.getAddress();
  console.log("TimeNFT deployed to:", contractAddress);

  // Mint first NFT
  console.log("Minting initial NFT...");
  const mintTx = await timeNFT.mint();
  await mintTx.wait();

  console.log("Successfully minted TimeNFT #1");
  console.log(`View contract: https://sepolia.etherscan.io/address/${contractAddress}`);
  console.log("You may need to wait a minute before viewing on marketplaces");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});