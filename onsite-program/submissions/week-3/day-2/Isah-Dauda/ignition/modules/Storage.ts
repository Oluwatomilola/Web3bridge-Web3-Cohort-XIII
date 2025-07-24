import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const StorageModule = buildModule("StorageModule", (m) => {
  const greeter = m.contract("Greeter"); // no constructor arguments

  return { greeter };
});

export default StorageModule;
