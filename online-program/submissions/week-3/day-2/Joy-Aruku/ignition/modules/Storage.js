const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("StorageModule", (m) => {
  const storage = m.contract("MessageStorage", []);
  return { storage };
});