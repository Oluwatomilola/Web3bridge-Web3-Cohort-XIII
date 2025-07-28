## Yesterday's Dive into Solidity Technicalities

### Data Locations
We have three main data locations:

1. **Storage**:
   - Used to save state variables (persistent data on blockchain)
   - Expensive in terms of gas costs
   - Visible across all function calls in the contract

2. **Memory**:
   - Temporary storage during function execution
   - Data is wiped after execution
   - Used for function parameters and local variables

3. **Stack**:
   - Stores computation/logic in functions
   - Limited to 1024 items (32 bytes each)

Additional locations:
- **Calldata**:
  - Special read-only location for function arguments
  - Similar to memory but can't be modified
- **Code**:
  - Not actually a data location (you were correct about this)
  - Contains the contract's bytecode

### Error Handling
We discussed:

1. **require(condition, "message")**:
   - Validates inputs/conditions
   - Returns unused gas when failing
   - Shows error message to users
   - Best pratice is to declare it before the function that uses it, and also to declare a string that shos the error

2. **assert(condition)**:
   - Used for internal errors that should never happen
   - Returns unsued gas 
   - Creates Panic error type

3. **revert()**:
   - Immediately stops execution
   - Can use custom errors 

### Inheritance
- Use `is` keyword: `contract B is A`
- To make function overridable: add `virtual`
- To override function: add `override`
- Yes, contracts can inherit from multiple parents

### ABI Encoding/Decoding
- Encoding converts data to bytes
- Decoding converts bytes back to data
- Two ways to encode:
  - `abi.encode()` (standard)
  - `abi.encodePacked()` (compact)

### Calling Contracts
 1. **by Interfaces**
 2. **Low-level calls** using:
  - `address.call{value: x}(data)`
  - Returns (bool success, bytes data)

### Fallback Functions
- `fallback()` runs when no function matches
- `receive()` runs for plain ETH transfers
- If both exist and ETH is sent:
  1. First tries `receive()`
  2. If no `receive()`, tries `fallback()`
  3. If both fail, transaction reverts

### Sending/Receiving Ether
Three methods:
1. `transfer()` (2300 gas, reverts on fail)
2. `send()` (2300 gas, returns bool)
3. `call()` (forward all gas, returns bool) - most recommended because of security purposes

For receiving ETH:
- Use `payable` modifier
- Best practice: implement both `receive()` and `fallback()`
- If ETH receive fails, the whole transaction reverts