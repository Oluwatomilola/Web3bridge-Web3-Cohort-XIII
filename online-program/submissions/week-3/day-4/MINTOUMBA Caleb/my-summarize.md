What I Learned in Solidity Yesterday: Data Types, Variables & Smart Contract Basics

Yesterday’s class we have focused on the fundamentals of Solidity, the programming language used to develop smart contracts on the Ethereum blockchain. we studied data types, how variables work, and how smart contracts are structured—all essential topics for dApps.

Solidity is statically typed, meaning that every variable must have its data type explicitly declared. This allows the compiler to catch errors and assign default values. For instance, a boolean defaults to false, and numbers default to zero.

There are two main categories of data types in Solidity:

Value types hold their data directly. When passed to a function or assigned to another variable, they are copied. These include booleans (true/false), integers (int for signed, uint for unsigned values), addresses (20-byte Ethereum wallet identifiers), and enums (named constants like Pending, Approved, Rejected). bytes and string types are used to store characters, with bytes being more gas-efficient for fixed-length data, while string is used for dynamic text, though it consumes more gas.

Reference types store data by reference, not by value. If two variables reference the same data, changes to one affect the other. Reference types include arrays (fixed or dynamic), strings (which are essentially arrays of characters), structs (custom groupings of related data like a student’s name, age, and grade), and mappings (key-value data structures used for things like tracking token balances by wallet address).

A Solidity smart contract is similar to a class in object-oriented programming. It’s compiled into bytecode and deployed to the Ethereum Virtual Machine (EVM) becaus the EVM understand only bytecode, it doesn't understand solidity code directly. Key elements of a smart contract include:

The SPDX license identifier, which declares the licensing terms.

The pragma directive, which defines the compiler version 
The contract keyword, which defines the start of the contract.
Functions, which are blocks of logic with specific input and output types.
Functions also include visibility modifiers:

public: accessible from anywhere, including other contracts.

private: only accessible within the same contract.

internal: accessible within the contract and its derived contracts.

external: can only be called from outside the contract.

Functions can also include state mutability modifiers:

view: reads but doesn’t modify the state.

pure: does not read or modify state, used for isolated logic.

payable: allows the function to receive Ether.

Variable scope is also important. There are:

State variables: declared outside functions and stored permanently on the blockchain.

Local variables: declared inside functions and exist temporarily during execution.

Global variables: built-in variables provided by Solidity, like msg.sender (who sent the transaction) or block.timestamp.

Solidity also supports constants and immutables. Constants are assigned hardcoded values at compile time, while immutables can be set once at deployment through the constructor.

The contract lifecycle includes four stages: compile time (code becomes bytecode), construction time (constructor runs if present), deployment (bytecode is uploaded to the blockchain), and runtime (contract can now be interacted with the blockchain).

Interfaces in Solidity define function signatures without implementations, allowing contracts to interact with other contracts (like ERC-20 tokens) by simply knowing the interface and address. Abstract contracts are templates with unimplemented functions and can contain other logic too. They must be inherited and completed before use.

For error handling, Solidity provides:
require(): checks a condition and reverts with a message if false. Ideal for validating inputs.
revert(): allows custom error messages and is more gas-efficient in some cases.

Thank you. 