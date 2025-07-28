# Inheritance in Solidity
    Inheritance in Solidity is a feature where a Child Contract inherits properties (data) and functions from another contract (Parent Contract). This enables developers reuse and extend code efficiently, reducing redundancy and promoting modular design.
    Inheritance is declared with the keyword "is" as in 

 ``` Contract B is A ```

    which means contract B inherits from contract A.

---

## Overriding functions
    Solidity allows child contracts to override functions inherited from parents, giving the child contract its own implementation. For this to happen, 
  - The parent function must be marked with the virtual keyword to indicate it can be overridden.
  - The overriding function in the child contract must use the override keyword.

---

## Function Overloading 
    Overloading happens when functions from boh parent and in child share the same name but differ in their argument types or number of arguments. These are treated as entirely separate functions and don't need special keywords.

#### Solidity supports multiple inheritance, meaning one contract can inherit from several contracts

#### When a contract inherits from others, the compiler flattens the entire inheritance chain into a single compiled contract on-chain. This combined contract contains all code and variables from the entire hierarchy. 