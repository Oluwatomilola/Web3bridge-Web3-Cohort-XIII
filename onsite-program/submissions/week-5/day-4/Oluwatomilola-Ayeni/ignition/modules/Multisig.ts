import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const Multisig = buildModule("Multisig", (m) => {
  const Multisig = m.contract("Multisig");
  return { Multisig };
});

export default Multisig;