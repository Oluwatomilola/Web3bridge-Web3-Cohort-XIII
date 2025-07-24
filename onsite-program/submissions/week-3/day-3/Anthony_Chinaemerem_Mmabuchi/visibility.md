# Solidity Visibility Specifiers Guide

## Overview

Solidity provides four visibility specifiers that control access to variables and functions within smart contracts. These specifiers determine who can access or call these elements from different contexts.

## Visibility Specifiers

### 1. Public

**For Variables:**
- Automatically creates a getter function
- Accessible from anywhere (within contract, derived contracts, and externally)
- Can be read by other contracts and external accounts

**For Functions:**
- Can be called from anywhere
- Accessible internally, by derived contracts, and externally
- Part of the contract's ABI (Application Binary Interface)

```solidity
contract Example {
    uint256 public publicVar = 100;  // Auto-generates getter
    
    function publicFunction() public pure returns (string memory) {
        return "Accessible everywhere";
    }
}
```

### 2. Private

**For Variables:**
- Only accessible within the same contract
- Not visible to derived contracts
- No automatic getter function created

**For Functions:**
- Only callable from within the same contract
- Not accessible from derived contracts or externally
- Not part of the contract's ABI

```solidity
contract Example {
    uint256 private privateVar = 50;  // Only accessible in this contract
    
    function privateFunction() private pure returns (string memory) {
        return "Only accessible within this contract";
    }
    
    function usePrivate() public view returns (uint256) {
        return privateVar;  // Can access private variable internally
    }
}
```

### 3. Internal

**For Variables:**
- Accessible within the contract and derived contracts
- Not accessible externally
- No automatic getter function created

**For Functions:**
- Callable from within the contract and derived contracts
- Not accessible externally
- Not part of the contract's ABI
- Default visibility for functions if not specified

```solidity
contract Parent {
    uint256 internal internalVar = 75;
    
    function internalFunction() internal pure returns (string memory) {
        return "Accessible in this contract and child contracts";
    }
}

contract Child is Parent {
    function accessInternal() public view returns (uint256) {
        return internalVar;  // Can access parent's internal variable
    }
}
```

### 4. External

**For Variables:**
- Not applicable to state variables
- Only used for function parameters in some contexts

**For Functions:**
- Only callable from outside the contract
- Not callable internally (unless using `this.functionName()`)
- Part of the contract's ABI
- More gas-efficient than public functions when called externally

```solidity
contract Example {
    function externalFunction() external pure returns (string memory) {
        return "Only callable from outside";
    }
    
    function callExternal() public view returns (string memory) {
        // Must use 'this' to call external function internally
        return this.externalFunction();
    }
}
```

## Comparison Table

| Visibility | Same Contract | Derived Contract | External Access | Auto Getter |
|-----------|---------------|------------------|-----------------|-------------|
| **public** | ✅ | ✅ | ✅ | ✅ (variables) |
| **private** | ✅ | ❌ | ❌ | ❌ |
| **internal** | ✅ | ✅ | ❌ | ❌ |
| **external** | ❌* | ❌* | ✅ | N/A |

*Can be called internally using `this.functionName()`

## Best Practices

### Security Considerations
- Use the most restrictive visibility possible
- `private` and `internal` don't provide true privacy on blockchain (data is still readable)
- Be careful with `public` variables containing sensitive information

### Gas Optimization
- `external` functions are more gas-efficient than `public` for external calls
- `public` variables create getter functions that consume gas

### Design Patterns
- Use `internal` for functions meant to be overridden in derived contracts
- Use `private` for implementation details that shouldn't be accessed by child contracts
- Use `external` for functions that are only meant to be called by other contracts or EOAs

## Example Contract

```solidity
pragma solidity ^0.8.0;

contract VisibilityExample {
    // Variables
    uint256 public publicCounter = 0;       // Anyone can read
    uint256 private privateSecret = 42;     // Only this contract
    uint256 internal protectedValue = 100;  // This contract + children
    
    // Functions
    function publicIncrement() public {
        publicCounter++;
    }
    
    function externalReset() external {
        publicCounter = 0;
    }
    
    function internalHelper(uint256 _value) internal pure returns (uint256) {
        return _value * 2;
    }
    
    function privateCalculation() private view returns (uint256) {
        return privateSecret + protectedValue;
    }
    
    // Demonstrating access
    function demonstrateAccess() public view returns (uint256) {
        // Can access all internal elements
        uint256 result = internalHelper(protectedValue);
        return result + privateCalculation();
    }
}

contract Child is VisibilityExample {
    function childFunction() public view returns (uint256) {
        // Can access public and internal from parent
        return publicCounter + protectedValue + internalHelper(10);
        // Cannot access privateSecret or privateCalculation()
    }
}
```

## Key Takeaways

- **Default visibility**: Functions are `internal` by default, state variables are `private` by default
- **Public variables**: Automatically generate getter functions
- **External functions**: More gas-efficient for external calls but require `this.` for internal calls
- **Inheritance**: `internal` and `public` elements are inherited, `private` elements are not
- **Security**: Visibility affects access control but doesn't provide true data privacy on blockchain