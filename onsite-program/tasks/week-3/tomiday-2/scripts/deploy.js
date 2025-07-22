const hre = require("hardhat");

async function main() {
  console.log("Deploying Storage contract to Lisk Sepolia...");

  // Deploy the Storage contract
  const Storage = await hre.ethers.getContractFactory("Storage");
  const storage = await Storage.deploy();
  await storage.deployed();

  console.log("Storage contract deployed to:", storage.address);

  // Wait for 30 seconds to ensure transaction is mined
  console.log("Waiting for 30 seconds before verification...");
  await new Promise(resolve => setTimeout(resolve, 30000));

  // Verify the contract
  console.log("Verifying contract on Blockscout...");
  try {
    await hre.run("verify:verify", {
      address: storage.address,
      constructorArguments: [],
    });
    console.log("Contract verified successfully on Blockscout!");
  } catch (error) {
    console.error("Verification failed:", error.message);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });