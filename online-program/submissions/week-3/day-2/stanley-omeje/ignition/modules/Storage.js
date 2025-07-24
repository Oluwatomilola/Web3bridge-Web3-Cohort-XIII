const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("StorageModule", (m) => {
  // Deploy the Storage contract (no constructor parameters needed)
  const storage = m.contract("Storage");
  
  // If you wanted to call store() immediately after deployment:
  // m.call(storage, "store", [42]); // Stores 42 immediately
  
  return { storage };
});