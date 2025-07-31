import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";



const Web3bridgeModule = buildModule("Web3bridgeModule", (m) => {
 

  const web3bridge  = m.contract("Web3bridge");

  return { web3bridge};
});

export default Web3bridgeModule;