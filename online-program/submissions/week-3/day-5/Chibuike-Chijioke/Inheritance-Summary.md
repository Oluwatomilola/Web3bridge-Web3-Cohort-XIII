# What is Inheritance?

Inheritance is a powerful concept in object-oriented programming (OOP) and Solidity. In Solidity, inheritance enables developers to create contracts that can inherit data and behavior from other contracts, leading to more modular, reusable, and manageable code.

Inheritance allows a child contract, derived contract, or subclass to inherit variables and functions from a parent contract. Inheritance facilitates convenient and extensive code reuse, meaning that it encourages code reuse, simplifies development, and reduces redundancy.

Solidity supports multiple inheritance, allowing a single contract to inherit features from multiple parent contract, unlike other programming languages such as Java.

To understand this inheritance relationship, the `is` keyword establishes it.

## How Does Basic Inheritance Work?

```solidity
//Parent Contract
contract A {
    string public constant A_NAME = "A";

    function getName() public pure returns (string memory) {
        return A_NAME;
    }
}
//child contract
contract B is A {
    string public constant B_NAME = "B";
}
```

Here, Contract B inherits all the variables and functions of Contract A, even though it doesn’t define them itself. If you deploy Contract B, you can call getName() and it will return "A", which is defined in Contract A.

## How Can a Child Contract Override a Parent's Function?

To override a function, the parent function must be marked as `virtual`, and the overriding function in the child must be marked `override.` Below is an example of function override:

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

Note that if virtual or override is missing, Solidity throws a compiler error.

## What is the Difference Between Overriding and Overloading?

- **Overriding:** A child function replaces a parent function with the same name and signature.
- **Overloading:** Functions have the same name but different parameters.

Like functions, modifiers can be inherited and overridden. Use virtual in the parent modifier and override in the child contract.

## How Do You Handle Constructor Parameters with Inheritance?

When a parent contract has a constructor that takes parameters, the child contract must also supply those parameters. There are two ways to do this:

1. **In the inheritance list:**

Syntax Example:

```solidity
contract Parent {
    constructor(uint _x) { }
}

contract Child is Parent(100) { }
```

2. **In the child constructor:**

```solidity
contract Child is Parent {
    constructor(uint _x) Parent(_x) { }
}
```

Note that the second method is more flexible and commonly used, especially when parameters are dynamic.

## Summary

- Inheritance promotes code reuse in Solidity.
- Use `is` to inherit from one or more parent contracts.
- Mark functions `virtual` to allow them to be overridden.
- Use `override` in the child contract to redefine a function.
- Solidity supports both function overriding and function overloading.
- Constructors with parameters must be handled carefully in inheritance.
