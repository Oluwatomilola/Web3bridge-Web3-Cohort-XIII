import { expect } from "chai";
import { ethers } from "hardhat";
import type { ContractTransactionReceipt, ContractTransactionResponse } from "ethers";

const MIN_LOCK_AMOUNT_ETH = ethers.parseEther("0.01");
const BREAKING_FEE_PERCENT = 3n;
const BREAKING_FEE_DIVISOR = 100n;

async function getEventArgs(
  tx: ContractTransactionResponse,
  contractInterface: any,
  eventName: string
) {
  const receipt: ContractTransactionReceipt = await tx.wait();
  for (const log of receipt.logs) {
    try {
      const parsed = contractInterface.parseLog(log);
      if (parsed.name === eventName) {
        return parsed.args;
      }
    } catch {
      continue;
    }
  }
  throw new Error(`Event ${eventName} not found`);
}

describe("PiggyBankFactory + PiggyBankSavings", function () {
  let deployer: any;
  let alice: any;
  let bob: any;
  let factory: any;

  beforeEach(async function () {
    [deployer, alice, bob] = await ethers.getSigners();

    const Factory = await ethers.getContractFactory("PiggyBankFactory", deployer);
    factory = await Factory.deploy();
    await factory.waitForDeployment();
  });

  describe("Factory negative cases", function () {
    it("should revert if ERC20 savings created with zero token address", async function () {
      await expect(
        factory.connect(alice).createSavings("Bad", 0, false, ethers.ZeroAddress)
      ).to.be.revertedWith("Invalid token address");
    });
  });

  describe("Factory / ETH savings flow", function () {
    it("should revert if ETH deposit is zero", async function () {
      const tx = await factory
        .connect(alice)
        .createSavings("Alice ETH Save", 0, true, ethers.ZeroAddress);
      const args = await getEventArgs(tx, factory.interface, "SavingsCreated");
      const savings = await ethers.getContractAt("PiggyBankSavings", args.savingsContract);

      await expect(
        alice.sendTransaction({
          to: savings.target,
          value: 0n,
          data: savings.interface.encodeFunctionData("deposit", [0n]),
        })
      ).to.be.revertedWith("Deposit below minimum");
    });

    it("should revert if withdraw amount exceeds balance", async function () {
      const tx = await factory
        .connect(alice)
        .createSavings("Alice ETH Save", 0, true, ethers.ZeroAddress);
      const args = await getEventArgs(tx, factory.interface, "SavingsCreated");
      const savings = await ethers.getContractAt("PiggyBankSavings", args.savingsContract);

      const depositValue = ethers.parseEther("0.02");
      await alice.sendTransaction({
        to: savings.target,
        value: depositValue,
        data: savings.interface.encodeFunctionData("deposit", [0n]),
      });

      await expect(
        savings.connect(alice).withdraw(ethers.parseEther("0.03"))
      ).to.be.revertedWith("Insufficient balance");
    });
  });

  describe("ERC20 savings flow", function () {
    let erc20: any;

    beforeEach(async function () {
      const Token = await ethers.getContractFactory("ERC20PresetMinterPauser");
      erc20 = await Token.deploy("Test Token", "TST");
      await erc20.waitForDeployment();
    });

    it("should revert if deposit below ERC20 minimum", async function () {
      await erc20.connect(deployer).mint(alice.address, ethers.parseEther("10"));

      const tx = await factory
        .connect(alice)
        .createSavings("Small ERC20", 0, false, erc20.target);
      const args = await getEventArgs(tx, factory.interface, "SavingsCreated");
      const savings = await ethers.getContractAt("PiggyBankSavings", args.savingsContract);

      await erc20.connect(alice).approve(savings.target, ethers.parseEther("0.0001"));

      // The contract's check is `amount >= MINIMUM_LOCK_AMOUNT / 1e18`
      await expect(
        savings.connect(alice).deposit(0n)
      ).to.be.revertedWith("Amount below minimum");
    });

    it("should revert if transferFrom fails (no allowance)", async function () {
      await erc20.connect(deployer).mint(alice.address, ethers.parseEther("10"));

      const tx = await factory
        .connect(alice)
        .createSavings("No Approve", 0, false, erc20.target);
      const args = await getEventArgs(tx, factory.interface, "SavingsCreated");
      const savings = await ethers.getContractAt("PiggyBankSavings", args.savingsContract);

      await expect(
        savings.connect(alice).deposit(ethers.parseEther("1"))
      ).to.be.reverted; // transferFrom should fail
    });

    it("should revert if withdraw amount exceeds ERC20 balance", async function () {
      await erc20.connect(deployer).mint(alice.address, ethers.parseEther("10"));

      const tx = await factory
        .connect(alice)
        .createSavings("Too Much ERC20", 0, false, erc20.target);
      const args = await getEventArgs(tx, factory.interface, "SavingsCreated");
      const savings = await ethers.getContractAt("PiggyBankSavings", args.savingsContract);

      const depositAmount = ethers.parseEther("5");
      await erc20.connect(alice).approve(savings.target, depositAmount);
      await savings.connect(alice).deposit(depositAmount);

      await expect(
        savings.connect(alice).withdraw(ethers.parseEther("6"))
      ).to.be.revertedWith("Insufficient balance");
    });
  });

  describe("Positive flows (short form)", function () {
    it("ETH early withdraw applies penalty", async function () {
      const tx = await factory
        .connect(alice)
        .createSavings("ETH Save", 0, true, ethers.ZeroAddress);
      const args = await getEventArgs(tx, factory.interface, "SavingsCreated");
      const savings = await ethers.getContractAt("PiggyBankSavings", args.savingsContract);

      const depositValue = ethers.parseEther("1");
      await alice.sendTransaction({
        to: savings.target,
        value: depositValue,
        data: savings.interface.encodeFunctionData("deposit", [0n]),
      });

      const withdrawAmount = ethers.parseEther("0.5");
      const factoryBalanceBefore = await ethers.provider.getBalance(factory.target);
      await savings.connect(alice).withdraw(withdrawAmount);
      const factoryBalanceAfter = await ethers.provider.getBalance(factory.target);

      const expectedPenalty = (withdrawAmount * BREAKING_FEE_PERCENT) / BREAKING_FEE_DIVISOR;
      expect(factoryBalanceAfter).to.equal(factoryBalanceBefore + expectedPenalty);
    });
  });
});
