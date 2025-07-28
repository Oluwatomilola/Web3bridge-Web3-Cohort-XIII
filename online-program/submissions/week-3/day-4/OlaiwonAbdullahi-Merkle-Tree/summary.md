# What I Learned in Solidity Yesterday: Data Types, Variables & Smart Contract Basics

In yesterday’s class, we focused on the fundamentals of **Solidity**, the programming language used to develop smart contracts on the Ethereum blockchain. We studied **data types**, how **variables** work, and how **smart contracts** are structured—all essential topics for building decentralized applications (dApps).

## Solidity Basics

Solidity is **statically typed**, meaning every variable must have its data type explicitly declared. This helps the compiler catch errors early and assign default values. For example:

- A `bool` defaults to `false`
- Numbers (`int` or `uint`) default to `0`

---

## Data Types in Solidity

Solidity has two main categories of data types:

### 1. Value Types

These hold their data directly and are copied when assigned or passed to functions. They include:

- `bool`: `true` or `false`
- `int` / `uint`: Signed and unsigned integers
- `address`: 20-byte Ethereum wallet address
- `enum`: Named constants like `Pending`, `Approved`, `Rejected`
- `bytes`: Fixed-size raw data
- `string`: Dynamic-length text (less gas-efficient than `bytes`)

### 2. Reference Types

These store data by reference. If two variables point to the same data, changes to one affect the other. They include:

- `arrays`: Fixed or dynamic-length lists
- `strings`: Essentially arrays of characters
- `structs`: Custom groupings (e.g., student info with `name`, `age`, `grade`)
- `mappings`: Key-value store (e.g., tracking token balances by wallet address)

---

## Smart Contract Structure

A Solidity contract is similar to a **class** in object-oriented programming. It’s compiled into **bytecode** because the **Ethereum Virtual Machine (EVM)** can only understand bytecode—not raw Solidity code.

### Key Elements:

- **SPDX License Identifier**: Declares licensing terms
- **`pragma` Directive**: Specifies the Solidity compiler version
- **`contract` Keyword**: Starts the contract declaration
- **Functions**: Contain logic with inputs and outputs

---

## Function Visibility

Functions can be restricted with visibility keywords:

- `public`: Accessible from anywhere
- `private`: Only within the same contract
- `internal`: Within the contract and child contracts
- `external`: Only callable from outside the contract

---

## Function Mutability

Functions can also be marked with:

- `view`: Reads but does not modify the state
- `pure`: Doesn’t read or modify the state
- `payable`: Allows the function to receive Ether

---

## Variables and Scope

- **State Variables**: Declared outside functions and stored permanently on the blockchain
- **Local Variables**: Declared inside functions and exist temporarily
- **Global Variables**: Built-in variables like `msg.sender`, `block.timestamp`

Solidity also supports:

- **Constants**: Fixed values set at compile time
- **Immutables**: Set once during contract deployment via the constructor

---

## Contract Lifecycle

Solidity contracts go through these four main stages:

1. **Compile Time**: Code is turned into bytecode
2. **Construction Time**: Constructor logic (if any) runs
3. **Deployment**: Bytecode is deployed to the blockchain
4. **Runtime**: Contract can be interacted with

---

## Interfaces and Abstract Contracts

- **Interfaces** define function signatures without implementation. They’re useful for interacting with external contracts like ERC-20 tokens.
- **Abstract Contracts** act as templates with unimplemented functions and optional logic. They must be inherited and completed by another contract.

---

## Error Handling in Solidity

Solidity provides built-in methods for error handling:

- `require()`: Checks a condition and reverts with a message if false. Best for input validation.
- `revert()`: Used for custom errors and can be more gas-efficient.

---

Thank you.
