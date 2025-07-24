import { ethers, run } from "hardhat";
import { config } from "dotenv";

config();

async function main() {
  console.log("Deploying Storage contract to Lisk Sepolia...");
  
  const Storage = await ethers.getContractFactory("Storage");
  const storage = await Storage.deploy();
  
  await storage.waitForDeployment();
  
  const contractAddress = await storage.getAddress();
  console.log("Storage contract deployed to:", contractAddress);
  
  console.log("\nWaiting for block confirmations...");
  await storage.deploymentTransaction()?.wait(5);
  
  console.log("\nVerifying contract on Lisk Sepolia block explorer...");
  try {
    await run("verify:verify", {
      address: contractAddress,
      constructorArguments: [],
    });
    console.log("Contract verified successfully!");
  } catch (error) {
    console.error("Verification failed:", error);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
