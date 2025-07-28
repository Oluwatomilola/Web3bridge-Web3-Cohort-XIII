# Inheritance in Solidity

Inheritance is a concept in Solidity that allows one contract to acquire the properties and functions of another contract. It enables code reuse, modularity, and the creation of complex systems by building on top of existing contracts.
And unlike in some other programming languages solidity allows us to use multiple inheritance i.e one child contract can have multiple parents.

we can spot this using the keyword `is` .

## How Inheritance Works

- **Base Contract:** The contract whose properties and functions are inherited.
- **Derived Contract:** The contract that inherits from the base contract.

A derived contract can access all non-private state variables and functions of its base contract. 

### Syntax Example

```solidity
//Parent Contract(base coontract)
contract A {
    string public constant A_NAME = "A";

    function getName() public pure returns (string memory) {
        return A_NAME;
    }
}
//child contract(derived contract)
contract B is A {
    string public constant B_NAME = "B";
}
```

## Key Points

- **Visibility:** Only functions and variables marked as `public` or `internal` are accessible to derived contracts. `private` members are not inherited.
- **Override:** Derived contracts can override functions from base contracts using the `override` and `virtual` keywords.
- **Multiple Inheritance:** Solidity uses C3 Linearization (Method Resolution Order) to handle multiple inheritance and resolve conflicts.

### Example of Function Override

```solidity
contract A {
    function foo() public virtual pure returns (string memory) {
        return "A";
    }
}

contract B is A {
    function foo() public override pure returns (string memory) {
        return "B";
    }
}
```

It is also important to note that you only need to override a function if the name and the signature are identical.

Also, i learnt function modifiers are inheritable

## Inheritance with Constructor Parameters

Some constructors specify input parameters and so they need you to pass arguments to them when instantiating the smart contract. If that smart contract is a parent contract, then its derived contracts must also pass arguments to instantiate the parent contracts. And there are two ways to do this:

- **either in the statement that lists the parent contracts**
- **Or directly in the constructors function for each parent contract.**

### Example 

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Parent contract
contract parentA {
    function sayHello() public pure returns (string memory) {
        return "Hello from parentA!";
    }
}

// Child contract inheriting from parentA
contract childB is parentA {
    // childB automatically inherits sayHello() from parentA
    function sayHi() public pure returns (string memory) {
        return "Hi from childB!";
    }
}
```

## Why Use Inheritance?

- **Code Reusability:** Write common logic once and reuse it in multiple contracts.
- **Organization:** Separate concerns and organize code into logical components.
- **Extensibility:** Easily extend or modify contract behavior by inheriting and overriding.

---

**In summary:**  
Inheritance in Solidity allows contracts to build upon each other, promoting code reuse and modularity. It is a powerful feature for structuring smart contracts efficiently and securely.
