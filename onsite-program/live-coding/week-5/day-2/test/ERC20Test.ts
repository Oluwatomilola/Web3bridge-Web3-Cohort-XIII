import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import hre from "hardhat";

describe("ERC20", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deploy_erc20() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await hre.ethers.getSigners();

    const ERC20 = await hre.ethers.getContractFactory("ERC20");
    const erc20 = await ERC20.deploy();

    return { erc20, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Should get the right token name", async function () {
      const {erc20 } = await loadFixture(deploy_erc20);

      const token_name_ = "Token_Name";

      expect(await erc20.token_name()).to.equal(token_name_);
    });

    it("Should get the right token decimal", async function () {
      const {erc20 } = await loadFixture(deploy_erc20);

      const token_decimal_ = 18;

      expect(await erc20.get_decimals()).to.equal(token_decimal_);
    });

    it("It should get the accurate total supply", async function(){
      const {erc20} = await loadFixture(deploy_erc20);

      const total_supply_ = 10000000000000000000000n;

      expect(await erc20.totalSupply()).to.equal(total_supply_);
    });

    // it("Should set the right owner", async function () {
    //   const { lock, owner } = await loadFixture(deployOneYearLockFixture);
    //
    //   expect(await lock.owner()).to.equal(owner.address);
    // });

    // it("Should receive and store the funds to lock", async function () {
    //   const { lock, lockedAmount } = await loadFixture(
    //     deployOneYearLockFixture
    //   );
    //
    //   expect(await hre.ethers.provider.getBalance(lock.target)).to.equal(
    //     lockedAmount
    //   );
    // });
    //
    // it("Should fail if the unlockTime is not in the future", async function () {
    //   // We don't use the fixture here because we want a different deployment
    //   const latestTime = await time.latest();
    //   const Lock = await hre.ethers.getContractFactory("Lock");
    //   await expect(Lock.deploy(latestTime, { value: 1 })).to.be.revertedWith(
    //     "Unlock time should be in the future"
    //   );
    // });
  });

  // describe("Withdrawals", function () {
  //   describe("Validations", function () {
  //     it("Should revert with the right error if called too soon", async function () {
  //       const { lock } = await loadFixture(deployOneYearLockFixture);
  //
  //       await expect(lock.withdraw()).to.be.revertedWith(
  //         "You can't withdraw yet"
  //       );
  //     });
  //
  //     it("Should revert with the right error if called from another account", async function () {
  //       const { lock, unlockTime, otherAccount } = await loadFixture(
  //         deployOneYearLockFixture
  //       );
  //
  //       // We can increase the time in Hardhat Network
  //       await time.increaseTo(unlockTime);
  //
  //       // We use lock.connect() to send a transaction from another account
  //       await expect(lock.connect(otherAccount).withdraw()).to.be.revertedWith(
  //         "You aren't the owner"
  //       );
  //     });
  //
  //     it("Shouldn't fail if the unlockTime has arrived and the owner calls it", async function () {
  //       const { lock, unlockTime } = await loadFixture(
  //         deployOneYearLockFixture
  //       );
  //
  //       // Transactions are sent using the first signer by default
  //       await time.increaseTo(unlockTime);
  //
  //       await expect(lock.withdraw()).not.to.be.reverted;
  //     });
  //   });
  //
  //   describe("Events", function () {
  //     it("Should emit an event on withdrawals", async function () {
  //       const { lock, unlockTime, lockedAmount } = await loadFixture(
  //         deployOneYearLockFixture
  //       );
  //
  //       await time.increaseTo(unlockTime);
  //
  //       await expect(lock.withdraw())
  //         .to.emit(lock, "Withdrawal")
  //         .withArgs(lockedAmount, anyValue); // We accept any value as `when` arg
  //     });
  //   });
  //
  //   describe("Transfers", function () {
  //     it("Should transfer the funds to the owner", async function () {
  //       const { lock, unlockTime, lockedAmount, owner } = await loadFixture(
  //         deployOneYearLockFixture
  //       );
  //
  //       await time.increaseTo(unlockTime);
  //
  //       await expect(lock.withdraw()).to.changeEtherBalances(
  //         [owner, lock],
  //         [lockedAmount, -lockedAmount]
  //       );
  //     });
  //   });
  // });
});
