# Inheritance in Solidity

## What is Inheritance?

- Inheritance in programming is a way by which pieces of code inherit data and functions from other pieces of code 
- by importing and inserting them. They can then make use of these functions without having to redefine them. For solidity, a step further is taken- functions and data of contracts can be modified! And this method is

There are two important terms
Parent Contract:- The contract whose functions will be used
Child Contract:- The contract that inherits the functions.

The way to identify a child and parent contract is with the 'is' keyword. 

contract B is A {
    string public constant B_NAME = "B";
}

## Multiple Inheritance.

Unlike other lanuages, solidity allows one child to have multiple parents. This means that it can inherit data and functions from more than one contract and make use of it.

## Overriding

 You only need to **override** a function when it has **the same name and the same signature** (i.e., parameters and types) as a parent function.
- If two functions share the same name but have different arguments, that’s called **overloading**, not overriding. Solidity allows this because their signatures are different.

### Example:
```solidity
// In contract A
function getName() public pure returns (string memory) { ... }

// In contract B (overload)
function getName(string memory prefix) public pure returns (string memory) { ... }

If multiple contracts in an inheritance chain (A → B → C → D → E) all override the same function (e.g., getName()), the most derived version is the one that gets called—meaning the one in E

## Important notes

You can’t declare a state variable in a child contract with the same name and type as one in a parent contract. It leads to conflicts. Instead, you can reuse and update the inherited variable

Lastly, Even if a contract inherits from multiple parents, only one combined contract is deployed on the blockchain. Solidity flattens the entire inheritance hierarchy into a single compiled contract.

