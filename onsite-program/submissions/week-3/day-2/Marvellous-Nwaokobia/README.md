# Visibility in Solidity

Visibility in Solidity refers to the ability of a function or variable to be seen or accessed by other contracts. It specifies the extent to which a variable, function, or contract can be accessed from outside the region of the contract where it was defined. The scope of visibility can be adjusted depending on which portions of the software system need access to it.

There are four different types of visibility in Solidity:

## 1. Public

- Functions and variables can be accessed:
  - Inside the contract
  - Outside the contract
  - From other smart contracts
  - From external accounts
- This is the broadest and most permissive visibility level.

## 2. Private

- Functions and variables are **only accessible within the smart contract** that declares them.
- They **cannot** be accessed outside of the enclosing smart contract.
- This is the **most restrictive** of the four visibility types.

## 3. Internal

- Functions and variables can be accessed:
  - Within the contract that declares them
  - From derived (child) contracts that inherit from the declaring contract
- They **cannot** be accessed from outside the contract hierarchy.

## 4. External

- Applies **only to functions**, not variables.
- External functions:
  - **Cannot** be called from within the declaring contract or its derived contracts
  - **Can only** be called from outside the enclosing contract

---

Visibility specifiers are essential for ensuring security and encapsulation in smart contract development.
