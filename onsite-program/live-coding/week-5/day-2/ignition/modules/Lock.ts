// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const JAN_1ST_2030 = 1893456000;
const ONE_GWEI: bigint = 1_000_000_000n;

const LockModule = buildModule("LockModule", (m) => {
  const unerc20Time = m.getParameter("unerc20Time", JAN_1ST_2030);
  const erc20edAmount = m.getParameter("erc20edAmount", ONE_GWEI);

  const erc20 = m.contract("Lock", [unerc20Time], {
    value: erc20edAmount,
  });

  return { erc20 };
});

export default LockModule;
