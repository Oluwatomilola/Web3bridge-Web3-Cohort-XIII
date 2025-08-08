const {
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { expect } = require("chai");
const hre = require("hardhat");

describe("Multisig", function () {
  async function deployMultiSigFixture() {
    const [owner1, owner2, owner3, owner4, owner5, recipient] =
      await hre.ethers.getSigners();

    const Multisig = await hre.ethers.getContractFactory("Multisig");
    const multiSig = await Multisig.deploy([
      owner1.address,
      owner2.address,
      owner3.address,
      owner4.address,
      owner5.address,
    ]);

    // Send some ETH to the contract
    await owner1.sendTransaction({
      to: multiSig.target,
      value: hre.ethers.parseEther("10"),
    });

    return { multiSig, owner1, owner2, owner3, owner4, owner5, recipient };
  }

  describe("Constructor", function () {
    it("should set the five owners correctly", async function () {
      const { multiSig, owner1, owner2, owner3, owner4, owner5 } =
        await loadFixture(deployMultiSigFixture);

      expect(await multiSig.isOwner(owner1.address)).to.be.true;
      expect(await multiSig.isOwner(owner2.address)).to.be.true;
      expect(await multiSig.isOwner(owner3.address)).to.be.true;
      expect(await multiSig.isOwner(owner4.address)).to.be.true;
      expect(await multiSig.isOwner(owner5.address)).to.be.true;
    });
  });

  describe("submitTransaction", function () {
    it("should submit a transaction successfully", async function () {
      const { multiSig, owner1, recipient } = await loadFixture(
        deployMultiSigFixture
      );

      await multiSig
        .connect(owner1)
        .submitTransaction(recipient.address, hre.ethers.parseEther("1"), "0x");

      const [to, value, data, executed, signatures] =
        await multiSig.getTransaction(0);
      expect(to).to.equal(recipient.address);
      expect(value).to.equal(hre.ethers.parseEther("1"));
      expect(data).to.equal("0x");
      expect(executed).to.be.false;
      expect(signatures).to.equal(0);
    });
  });

  describe("signTransaction", function () {
    it("should sign a transaction and increase signature count", async function () {
      const { multiSig, owner1, owner2, recipient } = await loadFixture(
        deployMultiSigFixture
      );

      // Submit transaction
      await multiSig
        .connect(owner1)
        .submitTransaction(recipient.address, hre.ethers.parseEther("1"), "0x");

      // Sign transaction
      await multiSig.connect(owner1).signTransaction(0);

      const [, , , , signatures] = await multiSig.getTransaction(0);
      expect(signatures).to.equal(1);
    });
  });

  describe("getTransaction", function () {
    it("should return transaction details correctly", async function () {
      const { multiSig, owner1, recipient } = await loadFixture(
        deployMultiSigFixture
      );

      await multiSig
        .connect(owner1)
        .submitTransaction(
          recipient.address,
          hre.ethers.parseEther("2"),
          "0x1234"
        );

      const [to, value, data, executed, signatures] =
        await multiSig.getTransaction(0);
      expect(to).to.equal(recipient.address);
      expect(value).to.equal(hre.ethers.parseEther("2"));
      expect(data).to.equal("0x1234");
      expect(executed).to.be.false;
      expect(signatures).to.equal(0);
    });
  });

  describe("isOwner", function () {
    it("should return true for valid owner", async function () {
      const { multiSig, owner1 } = await loadFixture(deployMultiSigFixture);

      expect(await multiSig.isOwner(owner1.address)).to.be.true;
    });
  });

  describe("receive", function () {
    it("should accept ETH payments", async function () {
      const { multiSig, owner1 } = await loadFixture(deployMultiSigFixture);

      const initialBalance = await hre.ethers.provider.getBalance(
        multiSig.target
      );

      await owner1.sendTransaction({
        to: multiSig.target,
        value: hre.ethers.parseEther("5"),
      });

      const finalBalance = await hre.ethers.provider.getBalance(
        multiSig.target
      );
      expect(finalBalance - initialBalance).to.equal(
        hre.ethers.parseEther("5")
      );
    });
  });
});