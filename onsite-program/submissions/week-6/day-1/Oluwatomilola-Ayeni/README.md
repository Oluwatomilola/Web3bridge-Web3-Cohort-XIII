# Piggy Bank Factory

Objective

* Build a piggy bank that allow users to Join and create multiple savings account
* Allow them to save either ERC20 or Ethers: they should be able to choose.
* Make it a Factory
* We must be able to get the balance of each user and make the deployer of the factory the admin.
* Track how many savings account the account have.
* Track the lock period for each savings plan that a user has on their child contract and they must have different lock periods.
* And if they intend to withdraw before the lock period that should incur a 3% breaking fee that would be transferred to the account of the deployer of the factory.

RoadMap
Piggybank : Saving Plan - Lock Period : 3months, 6months, and 12 months plan
* Interest rates
* Penalty 3% for withdrawal before lock time
* 
* 
* Multiple users
* A User Can have Multiple savings account
* Saving Ethers or ERC20
* Get the balance of Each user
* Factory deployer_ Admin: (Account_ address)
* Can track the number of accounts a user have
* Can track the lock period each savings plan
* 
Child contract: savings plan

<!-- 
# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.ts
``` -->
