import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const TokenGatedDAOModule = buildModule("TokenGatedDAOModule", (m) => {
  // Deploy NFTWithRoles first
  const nftWithRoles = m.contract("NFTWithRoles", ["DAO Governance NFT", "DAONFT"]);

  // Deploy TokenGatedDAO with NFTWithRoles address as parameter
  const tokenGatedDAO = m.contract("TokenGatedDAO", [nftWithRoles]);

  return { 
    nftWithRoles,
    tokenGatedDAO 
  };
});

export default TokenGatedDAOModule;