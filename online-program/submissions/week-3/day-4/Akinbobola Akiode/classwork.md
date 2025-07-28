Summary of yesterday's lesson

Resources: 
1. https://www.geeksforgeeks.org/solidity/solidity-types/
2. https://www.freecodecamp.org/news/learn-solidity-handbook/

We spoke about solidity types which are classed into two:

- Value Types

*  Boolean
*  Integers (signed and unsigned)
*  Fixed point numbers
*  Address
*  Bytes
*  nums

- Reference types

*  Arrays
*  Strings
*  Struct 
*  Mapping

I also learnt about contracts and immutable functions in solidity.
Where contract has to be defined in the code while immutable can be defined in constructors.

 I also learnt about Interface and Abstracts, and how they are used to define the structure of contracts and enforce certain functions to be implemented in child contracts.

Contract states aswell is the current snapshot of the program, at a point in time during its execution. And we made example of telegram airdrops and how they take snapshots.

I learnt about state mutability keywords like: view, pure, and payable, and how they control what a function can do with the contract’s state and Ether.

I learnt uint has a default valuee of 256 so if not specified it auto-assigns that value.

Solidity data types were covered, such as uint, int, address, bool, string, and arrays, which are used to store different kinds of information in smart contracts.

I also learnt inheritance, and how contracts can inherit properties and functions from other contracts to promote code reuse and organization.

I learnt about Variable Scopes in Smart Contracts.

- State  Variable- is not a function scope and it stores permanent data in a smart contract.

- Local Variable- holds information for a short period of time and this doesn't store it on the blockchain.

- Global variable- Used an example like msg.sender yesterday as they are functions made available by Solidity and we don't need to specifically create or import them from anywhere.

We also discusseed visibility specifiers: public, private, Internal, external.

And how solidity supports implicit constructors.

there was also function modifiers:

In error handling i learnt:
function assert- uses up gas, while revert- saves gas (also allows custom error).

I also learnt since strings uses gas we can can bytes if its betweeen 1-32.