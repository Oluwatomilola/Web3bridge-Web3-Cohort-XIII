import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("Storage", function () {
  async function deployStorageFixture() {
    const [owner, otherAccount] = await hre.ethers.getSigners();
    const Storage = await hre.ethers.getContractFactory("Storage");
    const storage = await Storage.deploy();
    return { storage, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Should deploy and have initial value 0", async function () {
      const { storage } = await loadFixture(deployStorageFixture);
      expect(await storage.retrieve()).to.equal(0);
    });
  });

  describe("Store and Retrieve", function () {
    it("Should store a value and retrieve it", async function () {
      const { storage } = await loadFixture(deployStorageFixture);
      await storage.store(42);
      expect(await storage.retrieve()).to.equal(42);
    });
  });
});
