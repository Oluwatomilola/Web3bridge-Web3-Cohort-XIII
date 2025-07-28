## Solidity Visibility Specifiers


### Variable Visibility

Visibility is the degree of accessibility of a variable or a function as the case may be.
Generally there four visibilites for both variables and functions but singularly variables use three while function make use of all four types.
#### 1. Public
#### 2. Private
#### 3. Internal
#### 4. external

What happens when you dont assign a value to a variable or function??💡 I'll tell you later, I promise! 🤞

* **Public:**
    * **Description:** Public variables are accessible from anywhere, both within the contract/scope they are defined in and from external contracts/scopes. It is Often used for data that needs to be read or modified by other parts of the application or by external entities.
    * **USE CASE💡:** A `balance` variable in a cryptocurrency contract that needs to be readable by anyone.

* **Private:**
    * **Description:** Private variables are only accessible from within the contract/scope they are defined in. They cannot be accessed or modified by external contracts or even by derived contracts (in object-oriented programming contexts). Ideal for data that should remain internal to the contract and not be exposed to the outside world, ensuring data encapsulation and security.
    * **USE CASE💡:** An internal counter variable that tracks the number of times a specific internal function has been called.

* **Internal:**
    * **Description:** Internal variables are accessible only within the contract/scope they are defined in and by derived contracts/scopes (in object-oriented programming contexts). They are not directly accessible from external contracts. Useful for data that needs to be shared within an inheritance hierarchy but not exposed externally.
    * **USE CASE💡:** A base contract might have an `internal` variable representing a common configuration parameter that derived contracts need to access.


### Function Visibility

Functions can make use of all four visibility types, providing fine-grained control over their accessibility:

* **Public:**
    * **Description:** Public functions can be called from anywhere, including other contracts, external accounts, and internal functions within the same contract. Used for functions that represent the primary interface of the contract, allowing external interaction.
    * **USE CASE💡:** A `transfer()` function in a token contract that allows users to send tokens to each other.

* **Private:**
    * **Description:** Private functions can only be called from within the same contract/scope they are defined in. They are not accessible by external contracts or even by derived contracts. Best for helper functions or internal logic that should not be exposed or directly invoked from outside the contract.
    * **USE CASE💡:** A `_calculateTax()` function that is only called by an internal `processPayment()` function.

* **Internal:**
    * **Description:** Internal functions can be called from within the same contract/scope and by derived contracts/scopes. They are not directly callable by external accounts or contracts. Useful for functions that provide common functionality for an inheritance hierarchy but are not meant for external consumption.
    * **USE CASE💡:** An `internal _validateAddress()` function in a base contract that derived contracts can use for address validation before performing operations.

* **External:**
    * **Description:** External functions can only be called from outside the contract. They cannot be called internally by other functions within the same contract. Primarily used for functions that are intended to be invoked by external accounts or other contracts, optimizing gas costs in some blockchain environments (like Solidity).
    * **USE CASE💡:** A `deposit()` function that allows users to send funds to the contract from their external accounts.

Solidity provides four visibility specifiers to control access to variables and functions in contracts:

| Specifier    | Variables                          | Functions                          | Inheriting Contracts | External Calls |
|--------------|------------------------------------|------------------------------------|----------------------|----------------|
| `public`     | Accessible everywhere              | Accessible everywhere              | ✅ Yes               | ✅ Yes         |
| `private`    | Only within defining contract      | Only within defining contract      | ❌ No                | ❌ No          |
| `internal`   | Defining contract + child contracts| Defining contract + child contracts| ✅ Yes               | ❌ No          |
| `external`   | ❌ Not applicable                  | Only via external calls            | ✅ Yes               | ✅ Yes         |

 When a vraiable isn't assigned a value, a default value is added to it
 **Default Visibility**: 
   - Variables: `internal`  
   - Functions: `public`  
   - 
### Key Notes:

1. **Gas Efficiency**: 
   - `external` functions are cheaper for calls from outside the contract.
2. **Best Practices**:
   - Use `private` for sensitive data/functions.
   - Prefer `external` over `public` for functions only called externally.
   - Use `internal` for reusable code in child contracts.

Example in code:
```solidity
contract Example {
    uint256 public publicVar;  // Readable by anyone 
    uint256 private privateVar; // Only this contract
    uint256 internal internalVar; // This + child contracts
    
    function publicFunc() public {}       // Callable externally + internally
    function privateFunc() private {}     // Only this contract
    function internalFunc() internal {}   // This + child contracts
    function externalFunc() external {}   // Only via external calls
}
```
