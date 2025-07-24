const {
    loadFixture,
  } = require("@nomicfoundation/hardhat-toolbox/network-helpers");
  const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
  const { expect } = require("chai");
  
  describe("Storage", function () {
    // We define a fixture to reuse the same setup in every test.
    // We use loadFixture to run this setup once, snapshot that state,
    // and reset Hardhat Network to that snapshot in every test.
    async function deployStorage() {
  
      const Storage = await ethers.getContractFactory("Storage");
      const storage = await Storage.deploy();
  
      return { storage };
    }
  
    describe("Deployment", function () {
      it("Should deploy the storage contract", async function () {
        const { storage } = await loadFixture(deployStorage);
  
        expect(await storage.retrieve()).to.equal(0);
      });
    });
  
    describe("Storages", function () {
      describe("Validations", function () {
        it("Should store the number", async function () {
          const { storage } = await loadFixture(deployStorage);
          await storage.store(1);
          expect(await storage.retrieve()).to.equal(1);
        });
      });
    });
  });
  