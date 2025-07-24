// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const SherifModule = buildModule("SHerifModule", (m) => {
  const sherif = m.contract("Sherif");

  return { sherif };
});

export default SherifModule;
