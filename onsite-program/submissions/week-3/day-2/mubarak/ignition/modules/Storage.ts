import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const StorageModule = buildModule("StorageModule", (m) => {
  const storage = m.contract("Storage"); // no constructor arguments

  return { storage };
});

export default StorageModule;