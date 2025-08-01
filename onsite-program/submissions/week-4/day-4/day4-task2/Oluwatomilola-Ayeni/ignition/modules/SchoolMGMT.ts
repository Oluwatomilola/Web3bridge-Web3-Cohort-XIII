// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const SchoolManagementSystem = buildModule("SchoolManagementSystemModule", (m) => {
  const schoolMgmt = m.contract("SchoolManagementSystem", []);

  return {
    schoolMgmt,
  };
});

export default SchoolManagementSystem;

// npx hardhat ignition deploy ./ignition/modules/SchoolMGMT.ts --network lisk-sepolia
