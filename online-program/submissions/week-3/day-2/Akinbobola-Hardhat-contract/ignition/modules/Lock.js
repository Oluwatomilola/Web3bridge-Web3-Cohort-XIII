// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const JAN_1ST_2030 = 1893456000;
const ONE_GWEI = 1_000_000_000n;

module.exports = buildModule("LockModule", (s) => {
  const unlockTime = s.getParameter("unlockTime", JAN_1ST_2030);
  const lockedAmount = s.getParameter("lockedAmount", ONE_GWEI);

  const lock = s.contract("Lock", [unlockTime], {
    value: lockedAmount,
  });

  return { lock };
});
