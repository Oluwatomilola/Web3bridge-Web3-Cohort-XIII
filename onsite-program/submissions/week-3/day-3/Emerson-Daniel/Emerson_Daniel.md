# Visibility Specifiers

## Definition

Visibility specifiers in Solidity determine how functions and state variables can be accessed from different contexts within and outside a contract. They control the scope and accessibility of contract elements, ensuring proper encapsulation and security. According to the Solidity documentation, these specifiers define whether a function or variable can be called or accessed from external contracts, derived contracts, or only within the current contract.

## Visibility Modifiers

**Functions:** external, internal, public, private
**Variables:** internal, public, private

## External

**Functions:** External functions are part of the contract interface and can only be called from outside the contract or through `this.functionName()` from within the same contract. They cannot be called internally using just the function name. External functions are more gas-efficient when receiving large arrays of data because the parameters are stored in calldata rather than memory.

**Variables:** External visibility does not apply to state variables.

## Internal

**Functions:** Internal functions can only be accessed from within the current contract and contracts that inherit from it. They cannot be called from external contracts or accounts. Internal functions are useful for creating helper functions that should only be available to the contract family.

**Variables:** Internal state variables can be accessed from within the current contract and derived contracts. They act similarly to protected members in object-oriented programming, providing controlled access to contract data across inheritance hierarchies.

## Public

**Functions:** Public functions can be called from anywhere - externally by other contracts and accounts, and internally from within the same contract. Solidity automatically generates getter functions for public state variables. Public functions offer maximum accessibility but should be used carefully as they expand the contract's attack surface.

**Variables:** Public state variables automatically have getter functions created by the compiler, making them readable from outside the contract. Other contracts and external accounts can read these variables, while internal access works like any other state variable.

## Private

**Functions:** Private functions can only be called from within the contract where they are defined. They are not accessible to derived contracts or external entities. Private functions are ideal for internal logic that should remain completely encapsulated within the contract.

**Variables:** Private state variables can only be accessed from within the contract where they are declared. Even derived contracts cannot access private variables from their parent contracts. Note that "private" doesn't mean the data is hidden from blockchain observers - all blockchain data is publicly visible, but the variable cannot be accessed programmatically by other contracts.

## References

1. Solidity Documentation - Cheatsheet. (2024). *Solidity 0.8.31 documentation*. https://docs.soliditylang.org/en/latest/cheatsheet.html

2. Solidity Documentation - Contracts. (2024). *Solidity 0.8.31 documentation*. https://docs.soliditylang.org/en/latest/contracts.html

3. Coinmonks. (2022, June 25). Visibility of functions and variables in Solidity. *Medium*. https://medium.com/coinmonks/visibility-in-solidity-e758a4739c95

4. Developer.com. (2024, March 8). How to Manage Visibility of Variables and Functions in Solidity. https://www.developer.com/languages/variable-function-visibility-solidity/

5. Alchemy. (2024). What is function visibility in Solidity? https://www.alchemy.com/overviews/solidity-function-visibility