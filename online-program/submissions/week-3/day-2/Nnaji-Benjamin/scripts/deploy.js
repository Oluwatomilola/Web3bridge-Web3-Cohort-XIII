async function main() {
  const Storage = await ethers.getContractFactory("Storage");
  const storage = await Storage.deploy();
  await storage.waitForDeployment();

  console.log("Contract deployed to:", await storage.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
