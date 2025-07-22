const { expect } = require("chai");

describe("Storage Contract", function () {
  let Storage, storage, owner;

  beforeEach(async function () {
    // Get the ContractFactory and Signers
    Storage = await ethers.getContractFactory("Storage");
    [owner] = await ethers.getSigners();

    // Deploy a new Storage contract before each test
    storage = await Storage.deploy();
    await storage.deployed();
  });

  it("Should deploy the contract correctly", async function () {
    expect(storage.address).to.not.equal(0);
    expect(storage.address).to.match(/^0x[0-9a-fA-F]{40}$/);
  });

  it("Should have initial number value as 0", async function () {
    const number = await storage.retrieve();
    expect(number).to.equal(0);
  });

  it("Should store and retrieve a number correctly", async function () {
    const testValue = 42;
    await storage.store(testValue);
    const retrievedValue = await storage.retrieve();
    expect(retrievedValue).to.equal(testValue);
  });
});