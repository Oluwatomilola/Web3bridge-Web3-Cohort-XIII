import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("MultisigWalletModule", (m) => {
  const owners = [
    "0x516a7D66B428dF27607E626df2A276b9b0B30a80", // owner1
    "0xabcd...", // owner2
    "0x5678..."  // owner3
  ];
  const required = 3;

  const multisig = m.contract("MultisigWallet", [owners, required]);

  return { multisig };
});