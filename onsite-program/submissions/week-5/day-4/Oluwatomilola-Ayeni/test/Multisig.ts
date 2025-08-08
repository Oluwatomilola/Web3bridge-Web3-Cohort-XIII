import { expect } from "chai";
import { ethers } from "hardhat";
import { MultisigFactory, MultisigWallet } from "../typechain-types";

describe("MultisigFactory + MultisigWallet (3-of-N) — no events, TypeScript", function () {
  it("deploys wallet through factory, requires 3 confirmations, and executes transfer after 3 confirmations", async function () {
    const [deployer, owner1, owner2, owner3, owner4, recipient] = await ethers.getSigners();

    const FactoryFactory = await ethers.getContractFactory("MultisigFactory");
    const factory = (await FactoryFactory.deploy()) as MultisigFactory;
    await factory.deployed();

    const owners = [owner1.address, owner2.address, owner3.address, owner4.address];
    const required = 3;

    await factory.createWallet(owners, required);

    const wallets = await factory.getWallets();
    const walletAddress = wallets[wallets.length - 1];

    const WalletFactory = await ethers.getContractFactory("MultisigWallet");
    const wallet = WalletFactory.attach(walletAddress) as MultisigWallet;

    await deployer.sendTransaction({ to: wallet.address, value: ethers.utils.parseEther("1.0") });

    const beforeRecipientBal = await ethers.provider.getBalance(recipient.address);

    const walletAsOwner1 = wallet.connect(owner1);
    await walletAsOwner1.submitTransaction(recipient.address, ethers.utils.parseEther("0.6"), "0x");

    let txInfo = await wallet.getTransaction(0);
    expect(txInfo.numConfirmations).to.equal(1);

    await wallet.connect(owner2).confirmTransaction(0);
    txInfo = await wallet.getTransaction(0);
    expect(txInfo.numConfirmations).to.equal(2);

    await wallet.connect(owner3).confirmTransaction(0);
    txInfo = await wallet.getTransaction(0);
    expect(txInfo.numConfirmations).to.equal(3);

    await walletAsOwner1.executeTransaction(0);

    const afterRecipientBal = await ethers.provider.getBalance(recipient.address);
    const diff = afterRecipientBal.sub(beforeRecipientBal);
    expect(diff).to.equal(ethers.utils.parseEther("0.6"));

    txInfo = await wallet.getTransaction(0);
    expect(txInfo.executed).to.equal(true);
  });
});