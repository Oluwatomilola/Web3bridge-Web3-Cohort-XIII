# Solidity Learning Notes

Yesterday, I learned about **Solidity**, a statically typed programming language used for writing **smart contracts** on blockchain platforms like Ethereum. Below is a summary of the key concepts I explored:

## Data Types in Solidity
Solidity has two main categories of data types:

1. **Value Types**:
   - These are primitive data types that hold their values directly.
   - They are initialized to a **zero state** (e.g., `0` for integers, `false` for booleans).
   - Examples: `int`, `uint`, `bool`, `address`.

2. **Reference Types**:
   - These store the **location** (reference) of the data rather than the data itself.
   - Examples:
     - **Struct**: A custom data structure to group related variables.
     - **Array**: A collection of elements of the same type, either fixed or dynamic in size.
     - **Mapping**: A key-value pair storage, crucial for associating data (e.g., `mapping(address => uint) balances`).

   **Note**: Mappings are particularly important as they efficiently store and retrieve data using key-value pairs, commonly used for tracking balances or relationships.

## Components of a Smart Contract
A smart contract in Solidity includes several key components:

- **SPDX License Identifier**: A comment at the top of the file specifying the license (e.g., `// SPDX-License-Identifier: MIT`) to clarify the terms of use.
- **Pragma Directive**: Specifies the compiler version to ensure compatibility (e.g., `pragma solidity ^0.8.0;`).
- **Contract Structure**: Contracts are similar to **classes** in object-oriented programming, containing **functions** and **methods** to define behavior and logic.

## Visibility Modifiers
Solidity uses visibility modifiers to control access to functions and variables:

- **Public**: Accessible everywhere within the contract, in derived (child) contracts, outside the contract, and externally (e.g., via transactions).
- **External**: Only callable from outside the contract (e.g., by other contracts or transactions).
- **Private**: Only accessible within the contract where it’s defined.
- **Internal**: Accessible within the contract and its derived (child) contracts.

## Types of Variables
Solidity supports different types of variables based on their scope and storage:

- **State Variables**: Stored on the blockchain, persistent between function calls (e.g., declared at the contract level).
- **Local Variables**: Temporary variables defined within a function, not stored on the blockchain.
- **Global Variables**: Special variables provided by the blockchain environment (e.g., `msg.sender` for the caller’s address, `block.timestamp` for the current time).

## Constants and Immutability
- **Constant**: Variables marked as `constant` are set at compile time and cannot be changed afterward. They save gas by avoiding storage costs.
- **Immutable**: Variables marked as `immutable` are set during contract deployment (e.g., in the constructor) and cannot be modified afterward. They are also gas-efficient.

## Other Key Concepts
- **Constructor**: A special function that runs only once during contract deployment to initialize state variables.
- **Interface**: A blueprint for a contract, defining function signatures without implementation. Used to interact with other contracts.
- **Abstract Contract**: A contract that cannot be deployed on its own and may contain unimplemented (abstract) functions, meant to be inherited by other contracts.

## Error Handling
Solidity provides mechanisms to handle errors and ensure contract reliability:

- **Assert**: Used for internal error checking (e.g., invariants). If an `assert` condition fails, the transaction reverts, and all gas is consumed.
- **Require**: Used to validate conditions (e.g., user inputs). If a `require` condition fails, the transaction reverts, but unused gas is refunded.
- **Revert**: Explicitly triggers a transaction rollback with a custom error message, similar to `require`.

## Function Modifiers
- **Modifiers**: Reusable code snippets that can be applied to functions to enforce conditions or add behavior (e.g., restricting access with `onlyOwner`).
