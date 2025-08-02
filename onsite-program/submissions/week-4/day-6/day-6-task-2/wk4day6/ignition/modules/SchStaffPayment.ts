// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";


const SchStaffPaymentModule = buildModule("SchStaffPaymentModule", (m) => {

  const schStaffPayment = m.contract("SchStaffPayment" 
  );

  return { schStaffPayment };
});

export default SchStaffPaymentModule;
