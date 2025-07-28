## My Learning: Inheritance in Solidity

I learnt about **Inheritance in Solidity** from [GeeksforGeeks](https://www.geeksforgeeks.org/solidity/solidity-inheritance/). Inheritance is a core feature of Solidity that allows one contract to inherit functions and variables from another. It helps make smart contracts more modular, reusable, and easier to manage.

### Types of Inheritance

There are different types of inheritance in Solidity:

1. **Single Inheritance** – where one contract inherits from one parent
2. **Multi-Level Inheritance** – where a contract inherits from a parent, which itself inherited from another contract
3. **Hierarchical Inheritance** – where multiple contracts inherit from the same base contract
4. **Multiple Inheritance** – where a contract inherits from two or more parent contracts

### Key Rules I Learned

- Only `public` and `internal` members can be inherited
- A derived contract can override functions from a base contract, but the function signatures must match exactly
- The `super` keyword or the base contract name can be used to call parent functions
- In multiple inheritance, `super` calls are resolved based on the most derived contract

### My Takeaway

This topic helped me understand how Solidity supports clean and scalable contract development through inheritance.