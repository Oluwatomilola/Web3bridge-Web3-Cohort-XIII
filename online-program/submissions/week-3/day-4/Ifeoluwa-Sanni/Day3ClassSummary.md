## Solidity


Solidity is an object-oriented programming language influenced by C++, JavaScript and Python.Solidity usually compiles human readable code to machine readable code known as bytecode that runs on the Ethereum Virtual Machine (EVM). This bytecode gets deployed and stored on EVM or other EVM compatible machines. Solidity is used for writing Smart contracts.

## Components of Solidity
- The first comment which is a machine readable line ( // SPDX-License-Identifier: MIT) that specifies the licensing that covers the code.
- The pragma directive that is usually the first line of code in any Solidity file. Pragma is a directive that tells the compiler which compiler version it should use to convert the human-readable Solidity code to machine readable bytecode.
- Semicolons are essential in Solidity. 
- The contracts
- The functions which are executable codes.

## Variable Scope in Smart Contracts
There are three variable scope in Smart contracts
- **State Variables** : These store permanent data in the Smart contract. They are found inside the contract but outside the function
- **Local Variables** : These hold data for a very short time usually during computation. They are found inside the function and can not be accessed outside the function
- **Global Variables** : these variables and functions are “injected” into your code by Solidity, and made available without the need to specifically create or import them from anywhere. These provide information about the blockchain environment the code is running on and also include utility functions for general use in the program.

## Types of Visibilities
- **Public functions and variables** can be accessed inside the contract, outside it, from other smart contracts, and from external accounts.
- **Private functions and variables** are only accessible within the smart contract that declares them.
- **Internal visibility is similar** to private visibility, in that internal functions and variables can only be accessed from within the contract that declares them. 
- **The external visibility** specifier does not apply to variables - only functions can be specified as external.

## A constructor
It  is a special type of function which is executed once only on contract creation.

There are abstract and Interface Contracts

## Solidiity Data Types
- **Value Types:** These include uint, int, addresses, booleans, fixed size bytes
- **Reference Types:** These include Fixed size array, dynamic size array, bytes arrays, composite structs and mappings.
 **A struct**  is a piece of data that has one or more properties or attributes, and specifying each property’s data type and name. 

 ## Function Modifiers
 A modifier is a snippet of code that can run automatically before or after you run the main function.Modifiers can be inherited from parent contracts too. 

 ## Errors Handling in Solidity
 There are three approaches of handling errors in Solidity
 - **A require() function** to validate inputs, validate return values, and check other conditions before we proceed with our code logic.
 - **An assert() function** is quite similar to require() except that it throws an error with type Panic(uint256) rather than Error(string).
 -  **A revert() call** is used in the same situation as a require() but when the conditional logic is much more complex.