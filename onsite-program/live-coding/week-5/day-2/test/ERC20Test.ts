import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("ERC20", function () {
  async function deploy_erc20() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await hre.ethers.getSigners();

    const token_name_ = "Token_Name";

    const ERC20 = await hre.ethers.getContractFactory("ERC20");
    const erc20 = await ERC20.deploy();

    return { erc20, owner, otherAccount, token_name_ };
  }

  describe("Deployment", function () {
    it("Should get the right token name", async function () {
      const { erc20, token_name_ } = await loadFixture(deploy_erc20);

      expect(await erc20.token_name()).to.equal(token_name_);
    });

    it("Should get the right token decimal", async function () {
      const { erc20 } = await loadFixture(deploy_erc20);

      const token_decimal_ = 18;

      expect(await erc20.get_decimals()).to.equal(token_decimal_);
    });

    it("It should get the accurate total supply", async function () {
      const { erc20 } = await loadFixture(deploy_erc20);

      const total_supply_ = 10000000000000000000000n;

      expect(await erc20.totalSupply()).to.equal(total_supply_);
    });
  });

  describe("Deployment", function () {
    it("Should transfer the correct amount", async function () {
      const { erc20, otherAccount, owner } = await loadFixture(deploy_erc20);

      const amount = hre.ethers.parseEther("2");

      const owner_balance = await erc20.balanceOf(owner.address);

      await erc20.transfer(otherAccount, amount);

      const owner_balance_after = await erc20.balanceOf(owner.address);

      const other_account_balance = await erc20.balanceOf(otherAccount.address);

      expect(other_account_balance).to.equal(amount);

      expect(owner_balance_after).to.equal(owner_balance - amount);
    });

    it("Should revert with You're low on token balance", async function () {
      const { erc20, otherAccount } = await loadFixture(deploy_erc20);

      const amount = hre.ethers.parseEther("10001");

      const tx = erc20.transfer(otherAccount.address, amount);

      await expect(tx).to.be.revertedWith("You're low on token balance");
    });

    it("Should revert with you do not have enough allowance", async function () {
      const { erc20, owner, otherAccount } = await loadFixture(deploy_erc20);

      const amount = hre.ethers.parseEther("10001");

      const tx = erc20.transferFrom(
        owner.address,
        otherAccount.address,
        amount,
      );

      await expect(tx).to.be.revertedWithCustomError(
        erc20,
        "You_dont_have_enough_priviledge",
      );
    });
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
