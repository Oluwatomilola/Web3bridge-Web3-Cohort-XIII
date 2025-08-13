import { expect } from "chai";
import { ethers } from "hardhat";
import { time } from "@nomicfoundation/hardhat-network-helpers";
import { SignerWithAddress } from "@nomicfoundation/hardhat-ethers/signers";
import { NFTWithRoles, TokenGatedDAO } from "../typechain-types";

describe("Token Gated DAO", function () {
  let nftContract: NFTWithRoles;
  let daoContract: TokenGatedDAO;
  let owner: SignerWithAddress;
  let admin: SignerWithAddress;
  let member: SignerWithAddress;
  let nonMember: SignerWithAddress;
  let adminRole: string;
  let memberRole: string;

  beforeEach(async function () {
    [owner, admin, member, nonMember] = await ethers.getSigners();

    
    const NFTWithRoles = await ethers.getContractFactory("NFTWithRoles");
    nftContract = await NFTWithRoles.deploy("Test DAO NFT", "TDAO");
    await nftContract.waitForDeployment();

    const TokenGatedDAO = await ethers.getContractFactory("TokenGatedDAO");
    daoContract = await TokenGatedDAO.deploy(await nftContract.getAddress());
    await daoContract.waitForDeployment();

   
    adminRole = await nftContract.adminRole();
    memberRole = await nftContract.memberRole();

    
    await nftContract.mint(admin.address); 
    await nftContract.mint(member.address); 
    
    const thirtyDaysFromNow: number = (await time.latest()) + (30 * 24 * 60 * 60);
    await nftContract.grantRole(1, adminRole, thirtyDaysFromNow);
    await nftContract.grantRole(2, memberRole, thirtyDaysFromNow);
  });

  describe("Role Management", function () {
    it("Should grant and check roles correctly", async function () {
      expect(await nftContract.hasRole(1, adminRole)).to.be.true;
      expect(await nftContract.hasRole(2, memberRole)).to.be.true;
      expect(await nftContract.userHasRole(admin.address, adminRole)).to.be.true;
      expect(await nftContract.userHasRole(member.address, memberRole)).to.be.true;
    });

    it("Should handle role expiration", async function () {
      const oneHourFromNow: number = (await time.latest()) + 3600;
      await nftContract.mint(nonMember.address);
      await nftContract.grantRole(3, memberRole, oneHourFromNow);
      
      expect(await nftContract.hasRole(3, memberRole)).to.be.true;
      
      await time.increase(7200); 
      expect(await nftContract.hasRole(3, memberRole)).to.be.false;
    });
  });

  describe("Proposal Creation", function () {
    it("Should allow admin to create proposals", async function () {
      await daoContract.connect(admin).createProposal("Test proposal");
      const proposal = await daoContract.getProposal(1);
      expect(proposal.description).to.equal("Test proposal");
      expect(proposal.creator).to.equal(admin.address);
    });

    it("Should not allow non-admin to create proposals", async function () {
      await expect(
        daoContract.connect(member).createProposal("Test proposal")
      ).to.be.revertedWith("Must have admin role");
    });
  });

  describe("Voting", function () {
    it("Should allow members and admins to vote", async function () {
      await daoContract.connect(admin).createProposal("Test proposal");
      
      await daoContract.connect(admin).vote(1, true);
      await daoContract.connect(member).vote(1, false);
      
      const proposal = await daoContract.getProposal(1);
      expect(Number(proposal.yesVotes)).to.equal(1);
      expect(Number(proposal.noVotes)).to.equal(1);
    });

    it("Should not allow non-members to vote", async function () {
      await daoContract.connect(admin).createProposal("Test proposal");
      await expect(
        daoContract.connect(nonMember).vote(1, true)
      ).to.be.revertedWith("Must have member or admin role");
    });

    it("Should not allow double voting", async function () {
      await daoContract.connect(admin).createProposal("Test proposal");
      await daoContract.connect(admin).vote(1, true);
      
      await expect(
        daoContract.connect(admin).vote(1, false)
      ).to.be.revertedWith("Already voted");
    });
  });

  describe("Proposal Results", function () {
    it("Should determine if proposal passed", async function () {
      await daoContract.connect(admin).createProposal("Test proposal");
      await daoContract.connect(admin).vote(1, true);
      
      await time.increase(8 * 24 * 60 * 60); 
      expect(await daoContract.hasProposalPassed(1)).to.be.true;
    });

    it("Should not allow voting after period ends", async function () {
      await daoContract.connect(admin).createProposal("Test proposal");
      await time.increase(8 * 24 * 60 * 60);
      
      await expect(
        daoContract.connect(member).vote(1, true)
      ).to.be.revertedWith("Voting period ended");
    });
  });

  describe("Role Expiration in DAO", function () {
    it("Should prevent actions when roles expire", async function () {
      const oneHourFromNow: number = (await time.latest()) + 3600;
      await nftContract.mint(nonMember.address);
      await nftContract.grantRole(3, memberRole, oneHourFromNow);
      
      
      await daoContract.connect(admin).createProposal("Test proposal");
      await daoContract.connect(nonMember).vote(1, true);
      
    
      await time.increase(7200);
      await daoContract.connect(admin).createProposal("Another proposal");
      await expect(
        daoContract.connect(nonMember).vote(2, true)
      ).to.be.revertedWith("Must have member or admin role");
    });
  });
});