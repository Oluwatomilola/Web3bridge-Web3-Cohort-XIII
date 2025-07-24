# Akanimoh: Solidity Visibility Specifiers & Value Data Types

Hey there! Let’s dive into **Solidity’s visibility specifiers** and **value data types**. Visibility specifiers control who can access your variables and functions, while value data types are the building blocks for storing data in a smart contracts.

## Visibility Specifiers: Who Can Access What?

Visibility specifiers in Solidity (`public`, `private`, `internal`, `external`) determine the accessibility of variables and functions. They’re like setting permissions for contract’s data and logic.

- **Public**:
  - **Variables**: Accessible everywhere, inside the contract, derived contracts, or externally via transactions. Automatically gets a getter function. Example: `uint public score = 100;`anyone can read `score`.
  - **Functions**: Callable from anywhere (internally, by child contracts, or externally). Example: `function getScore() public view returns (uint) { return score; }`.
  - **Use Case**: Share data or functions with everyone, like token balances.

- **Private**:
  - **Variables**: Only the contract itself can access them. No derived contracts or external access. Example: `uint private secret = 42;` locked down tight.
  - **Functions**: Only callable within the contract. Example: `function hide() private { secret++; }`.
  - **Use Case**: Protect sensitive data or internal logic.

- **Internal**:
  - **Variables**: Accessible in the contract and its derived contracts, but not externally. Example: `uint internal level = 5;` open to the contract and its "kids."
  - **Functions**: Callable by the contract and derived contracts. Example: `function levelUp() internal { level++; }`.
  - **Use Case**: Share with child contracts in inheritance setups.

- **External**:
  - **Variables**: Solidity doesn’t allow `external` for variables.
  - **Functions**: Only callable externally (via transactions or other contracts), not internally unless using `this` (costs extra gas). Example: `function ping() external returns (uint) { return 1; }`.
  - **Use Case**: Gas-efficient for functions meant for external use, like contract APIs.

**NOTE**:
- **Defaults**: Variables default to `internal`; functions used to default to `public` (pre-Solidity 0.5.0). Always specify for clarity.
- **Security**: Use `private` or `internal` to restrict access; `public` is an open invite.
- **Gas**: `external` functions save gas for outside calls.

## Value Data Types: The Data Building Blocks

Value data types in Solidity are the core types for storing simple, fixed-size data directly in variables. They’re passed by value (copied when used), unlike reference types (like arrays or structs). Here are examples:

- **Boolean (`bool`)**:
  - Stores `true` or `false`.
  - Example: `bool isActive = true;`.
  - Use Case: Flags or conditions, like `if (isActive) { ... }`.
  - Size: 1 byte.

- **Integer (`int` / `uint`)**:
  - Signed (`int`) or unsigned (`uint`) integers, ranging from 8 to 256 bits (e.g `uint8`, `int256`).
  - Example: `uint256 balance = 1000;` (0 to 2^256-1); `int32 temp = -50;` (signed).
  - Use Case: Counters, balances, or calculations.
  - Default: `uint256` or `int256` if unspecified.

- **Address**:
  - Holds a 20-byte Ethereum address. Two flavors:
    - `address`: Basic address, e.g., `address owner = msg.sender;`.
    - `address payable`: Can send/receive Ether, e.g `address payable recipient;`.
  - Use Case: Store wallet or contract addresses for transfers or calls.
  - Example: `recipient.transfer(1 ether);` (only with `payable`).

- **Bytes (`bytes1` to `bytes32`)**:
  - Fixed-size byte arrays (1 to 32 bytes), e.g., `bytes32 hash = keccak256("data");`.
  - Use Case: Store hashes or fixed-length raw data.
  - Note: Cheaper than dynamic `bytes` (a reference type).

- **Enum**:
  - User-defined type for a set of named values.
  - Example: `enum Status { Pending, Active, Closed } Status state = Status.Pending;`.
  - Use Case: Define states, like order status in a marketplace.
  - Stored as integers (starts at 0).

## Example Using a Contract
```solidity
contract MyContract {
    // Visibility examples
    uint public score = 100;      // Everyone can see
    uint private secret = 42;     // Just this contract
    uint internal level = 5;      // This contract + derived
    address payable public owner = payable(msg.sender); // Payable address

    // Value data types
    bool public isActive = true;  // Boolean
    int32 public temp = -10;      // Signed integer
    bytes32 private hash = keccak256("data"); // Fixed bytes
    enum Status { Pending, Active, Closed } // Enum
    Status public state = Status.Pending;

    function publicFunc() public view returns (uint) { return score; }
    function privateFunc() private { secret++; }
    function internalFunc() internal { level++; }
    function externalFunc() external returns (bool) { return isActive; }
}

contract ChildContract is MyContract {
    function test() public view returns (uint) {
        return level; // Can access internal level
        // return secret; // Error: private!
    }
}
