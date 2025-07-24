# Solidity Visibility Specifiers

## Introduction
Visibility specifiers in Solidity control how state variables and functions in a smart contract can be accessed. They are essential for ensuring security and managing access in blockchain applications. Solidity provides four visibility specifiers: `public`, `private`, `internal`, and `external`. This document summarizes their behavior for state variables and functions.

## State Variable Visibility

### Public
Public state variables can be accessed by anyone, including external contracts and users. The Solidity compiler automatically generates a **getter function** to read their values. Within the contract, internal access (e.g., `x`) reads the variable directly from storage, while external access (e.g., `this.x`) uses the getter. Other contracts cannot modify public variables unless a setter function is explicitly defined.

**Example**:
```solidity
uint public myNumber = 42;
```

### Internal
Internal state variables are accessible only within the contract they are defined in and in derived contracts (through inheritance). They cannot be accessed externally. This is the default visibility for state variables.

**Example**:
```solidity
uint internal familySecret = 200;
```

### Private
Private state variables are accessible only within the contract they are defined in. They are **not** accessible in derived contracts or externally, making them the most restrictive visibility level.

**Example**:
```solidity
uint private secretNumber = 100;
```

**Note**: `external` visibility is not applicable to state variables.

## Function Visibility

### Public
Public functions are part of the contract’s interface and can be called internally (within the contract) or externally (via message calls from other contracts or transactions).

**Example**:
```solidity
function sayHello() public returns (string memory) {
    return "Hello!";
}
```

### Internal
Internal functions can only be called within the contract or by derived contracts. They are not exposed in the contract’s ABI, so they cannot be called externally. They can use internal types like mappings or storage references as parameters.

**Example**:
```solidity
function internalFunction() internal returns (uint) {
    return 200;
}
```

### Private
Private functions are only accessible within the contract they are defined in and are not visible to derived contracts. This makes them highly restrictive.

**Example**:
```solidity
function doSomethingPrivate() private returns (uint) {
    return 100;
}
```

### External
External functions are part of the contract’s interface and can only be called from outside the contract (e.g., by other contracts or transactions). They cannot be called internally using `f()`, but `this.f()` works from within the contract.

**Example**:
```solidity
function externalFunction() external returns (string memory) {
    return "Called from outside!";
}
```

## Visibility Specifiers Comparison

| Specifier | Variables | Functions | Access Scope |
|-----------|-----------|-----------|--------------|
| Public    | Yes       | Yes       | Accessible by anyone (inside/outside contract) |
| Private   | Yes       | Yes       | Only accessible within the contract |
| Internal  | Yes       | Yes       | Accessible within contract and derived contracts |
| External  | No        | Yes       | Only accessible from outside the contract |

## Conclusion
Visibility specifiers in Solidity are critical for controlling access to state variables and functions in smart contracts. By using `public`, `private`, `internal`, and `external` appropriately, developers can enhance security, protect sensitive data, and define clear interfaces for contract interactions.

*Submitted by Ogangbo Joseph*