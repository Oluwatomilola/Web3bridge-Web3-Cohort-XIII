# Solidity Visibility Specifiers: Variables and Functions

## Overview

Visibility specifiers in Solidity control access to state variables and functions from different contexts. They determine whether code can be accessed from within the same contract, derived contracts, or external contracts and accounts.

## Function Visibility Specifiers

### 1. Public

**Access Level**: Accessible from anywhere
- Within the same contract
- From derived contracts (inheritance)
- From external contracts
- From external accounts (EOAs)

**Characteristics**:
- Creates an automatic getter function for state variables
- Can be called internally and externally
- Most permissive visibility level

```solidity
contract Example {
    uint256 public publicVar = 100;
    
    function publicFunction() public pure returns (string memory) {
        return "Accessible from anywhere";
    }
}
```

### 2. External

**Access Level**: Only accessible from outside the contract
- From external contracts
- From external accounts (EOAs)
- **NOT** accessible from within the same contract (unless using `this.functionName()`)
- **NOT** accessible from derived contracts directly

**Characteristics**:
- Gas efficient for functions that are only called externally
- Cannot be applied to state variables
- Can be overridden in derived contracts

```solidity
contract Example {
    function externalFunction() external pure returns (string memory) {
        return "Only callable from outside";
    }
    
    function testExternal() public pure returns (string memory) {
        // This would cause an error:
        // return externalFunction();
        
        // Must use this.externalFunction() to call externally
        return this.externalFunction();
    }
}
```

### 3. Internal

**Access Level**: Accessible within the contract and derived contracts
- Within the same contract
- From derived contracts (inheritance)
- **NOT** accessible from external contracts
- **NOT** accessible from external accounts

**Characteristics**:
- Default visibility for state variables
- Enables inheritance patterns
- More gas efficient than public/external for internal calls

```solidity
contract Parent {
    uint256 internal internalVar = 50;
    
    function internalFunction() internal pure returns (string memory) {
        return "Accessible within contract hierarchy";
    }
}

contract Child is Parent {
    function useInternalFunction() public pure returns (string memory) {
        return internalFunction(); // Can access parent's internal function
    }
    
    function getInternalVar() public view returns (uint256) {
        return internalVar; // Can access parent's internal variable
    }
}
```

### 4. Private

**Access Level**: Only accessible within the same contract
- Within the same contract only
- **NOT** accessible from derived contracts
- **NOT** accessible from external contracts
- **NOT** accessible from external accounts

**Characteristics**:
- Most restrictive visibility level
- Ensures complete encapsulation
- Cannot be overridden in derived contracts

```solidity
contract Example {
    uint256 private privateVar = 25;
    
    function privateFunction() private pure returns (string memory) {
        return "Only accessible within this contract";
    }
    
    function usePrivateFunction() public pure returns (string memory) {
        return privateFunction(); // Can call private function within same contract
    }
}

contract Derived is Example {
    function tryAccessPrivate() public pure returns (string memory) {
        // This would cause compilation errors:
        // return privateFunction();
        // return privateVar;
        
        return "Cannot access private members from parent";
    }
}
```

## State Variable Visibility

### Default Behavior
- State variables have **internal** visibility by default
- Only `public`, `internal`, and `private` are valid for state variables
- `external` cannot be applied to state variables

### Public State Variables
```solidity
contract StateExample {
    uint256 public publicCounter = 0;
    
    // Automatically creates this getter function:
    // function publicCounter() public view returns (uint256) {
    //     return publicCounter;
    // }
}
```

### Internal State Variables
```solidity
contract StateExample {
    uint256 internal internalCounter = 0; // Explicit declaration
    uint256 implicitInternal = 0;         // Implicit internal visibility
}
```

### Private State Variables
```solidity
contract StateExample {
    uint256 private privateCounter = 0;
    
    function getPrivateCounter() public view returns (uint256) {
        return privateCounter; // Only accessible within this contract
    }
}
```

## Visibility Summary Table

| Visibility | Same Contract | Derived Contracts | External Contracts | External Accounts | State Variables |
|------------|---------------|-------------------|-------------------|-------------------|-----------------|
| **public** | Yes | Yes | Yes | Yes | Yes |
| **external** | No* | No* | Yes | Yes | No |
| **internal** | Yes | Yes | No | No | Yes (default) |
| **private** | Yes | No | No | No | Yes |

*Can be accessed using `this.functionName()`

## Best Practices

### Security Considerations
1. **Principle of Least Privilege**: Use the most restrictive visibility that meets your requirements
2. **Private by Default**: Start with private visibility and increase as needed
3. **External for Interface Functions**: Use external for functions that should only be called from outside

### Gas Optimization
1. **External vs Public**: External functions are more gas-efficient when called externally
2. **Internal for Inheritance**: Use internal for functions shared across contract hierarchy
3. **Private for Encapsulation**: Use private for internal helper functions

### Code Organization
```solidity
contract WellOrganized {
    // State variables
    uint256 private _counter;
    uint256 internal _baseValue;
    uint256 public totalSupply;
    
    // External interface functions
    function increment() external {
        _incrementCounter();
    }
    
    function getCounter() external view returns (uint256) {
        return _counter;
    }
    
    // Public functions (callable internally and externally)
    function reset() public {
        _counter = 0;
    }
    
    // Internal functions (for inheritance)
    function _calculateBase() internal view returns (uint256) {
        return _baseValue * 2;
    }
    
    // Private functions (implementation details)
    function _incrementCounter() private {
        _counter++;
    }
}
```

## Common Pitfalls

### 1. External Function Access
```solidity
contract Pitfall {
    function externalFunc() external pure returns (uint256) {
        return 42;
    }
    
    function internalCall() public pure returns (uint256) {
        // This will fail
        // return externalFunc();
        
        // Correct way
        return this.externalFunc();
    }
}
```

### 2. Inheritance Visibility
```solidity
contract Parent {
    function privateFunc() private pure returns (uint256) {
        return 1;
    }
    
    function internalFunc() internal pure returns (uint256) {
        return 2;
    }
}

contract Child is Parent {
    function test() public pure returns (uint256) {
        // Cannot access private functions from parent
        // return privateFunc();
        
        // Can access internal functions from parent
        return internalFunc();
    }
}
```

### 3. State Variable Misconceptions
```solidity
contract StateVars {
    // This is invalid - external not allowed for state variables
    // uint256 external invalidVar;
    
    uint256 public validVar;     // Creates automatic getter
    uint256 internal defaultVar; // Default behavior
    uint256 private secretVar;   // Most restrictive
}
```

## Conclusion

Understanding Solidity visibility specifiers is crucial for:
- **Security**: Preventing unauthorized access to sensitive functions and data
- **Gas Efficiency**: Choosing the right visibility for optimal performance
- **Code Architecture**: Designing clean, maintainable smart contracts
- **Inheritance**: Properly structuring contract hierarchies
