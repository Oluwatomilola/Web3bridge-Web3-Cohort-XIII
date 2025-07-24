import { ethers } from "hardhat";

async function main() {
  const Storage = await ethers.getContractFactory("Storage");
  const storage = await Storage.deploy();
  await storage.waitForDeployment(); // ✅ Use this instead of .deployed()
  
  const address = await storage.getAddress();
  console.log(`Storage deployed to: ${address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
