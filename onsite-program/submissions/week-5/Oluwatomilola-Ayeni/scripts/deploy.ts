import { ethers } from "hardhat";

async function main() {
  // Replace with your Pinata CID for the NFT metadata
  const tokenURI = "ipfs://bafkreiazxf54yqgook67zj5vwaew3bz5gsveupigri5ogeo7262je7gswa"; // e.g., ipfs://Qm...xyz
  // Replace with the recipient address for the NFT
  const recipient = "0x516a7D66B428dF27607E626df2A276b9b0B30a80"; // e.g., 0x123...abc

  // Get the deployer's address
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contract with account:", deployer.address);

  // Deploy the TomiNFT contract
  const TomiNFT = await ethers.getContractFactory("TomiNFT");
  const tomiNFT = await TomiNFT.deploy(deployer.address);
  await tomiNFT.waitForDeployment();
  console.log("TomiNFT deployed to:", await tomiNFT.getAddress());

  // Mint one NFT
  const tx = await tomiNFT.mintNFT(recipient, tokenURI);
  const receipt = await tx.wait();
  console.log("NFT minted with token ID 1 to:", recipient);
  console.log("Transaction hash:", receipt.hash);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });