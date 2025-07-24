# Solidity Visibility Specifiers

In Solidity, visibility specifiers control access to variables and functions in a contract. They define how and where these elements can be accessed. Below is a summary of the four visibility specifiers: `public`, `private`, `internal`, and `external`.

## Visibility Specifiers

### 1. Public
- **Variables**: 
  - Accessible from within the contract, derived contracts, external contracts, and externally via transactions.
  - Automatically generates a getter function for the variable.
- **Functions**: 
  - Can be called internally, externally, or by derived contracts.
  - Accessible from anywhere, including external accounts via transactions.

### 2. Private
- **Variables**: 
  - Only accessible within the contract they are defined in.
  - Not accessible in derived contracts or externally.
- **Functions**: 
  - Only callable within the contract they are defined in.
  - Not accessible by derived contracts or external calls.

### 3. Internal
- **Variables**: 
  - Accessible within the contract and in derived contracts.
  - Not accessible externally (no automatic getter generated).
- **Functions**: 
  - Callable within the contract and derived contracts.
  - Not accessible from external accounts or contracts.

### 4. External
- **Variables**: 
  - Not applicable (cannot be used for variables).
- **Functions**: 
  - Only callable from external contracts or accounts via transactions.
  - Cannot be called internally without using `this` (e.g., `this.myFunction()`).

## Key Notes
- **Default Visibility**: 
  - Variables default to `internal` if no specifier is provided.
  - Functions default to `public` if no specifier is provided (Solidity versions < 0.5.0; always specify for clarity in newer versions).
- **Gas Considerations**: 
  - `external` functions can be more gas-efficient for external calls since they don't require internal call overhead.
  - `public` variables generate getters, increasing deployment gas costs.
- **Best Practices**: 
  - Use `private` or `internal` for sensitive data to restrict access.
  - Explicitly declare visibility for all variables and functions to avoid unintended access.

## Example
```solidity
contract VisibilityExample {
    uint public publicVar = 1;    // Accessible everywhere
    uint private privateVar = 2;  // Only within this contract
    uint internal internalVar = 3; // Within this and derived contracts

    function publicFunction() public view returns (uint) { return publicVar; } // Callable everywhere
    function privateFunction() private view returns (uint) { return privateVar; } // Only within contract
    function internalFunction() internal view returns (uint) { return internalVar; } // Within contract and derived
    function externalFunction() external view returns (uint) { return publicVar; } // Only external calls
}