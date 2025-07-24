# Visibility Specifiers in Solidity: Variables vs. Functions

Solidity's visibility specifiers control who can access state variables and functions in a smart contract. They're crucial for managing security, encapsulation, and interaction with other contracts or users. The four visibility levels—private, internal, public, and external—behave differently for variables and functions.

## Overview of Visibility Specifiers

- **Private**: Restricted to the defining contract.
- **Internal**: Accessible in the defining contract and its derived contracts.
- **Public**: Accessible from anywhere (internally, derived contracts, externally).
- **External**: Only accessible from outside the contract (not internally without workarounds).


## 1. private

### Variables

- **Access**: Only within the contract where defined. Not accessible in derived contracts or externally.
- **Use Case**: Protects sensitive data, like internal counters or configuration settings, from external access or inheritance.

### Functions

- **Access**: Callable only within the defining contract. Not accessible in derived contracts or externally.
- **Use Case**: Internal helper functions, like calculations or validation logic, that shouldn't be exposed.


### Example

```solidity
contract Token {
    uint private feeAccumulator;

    function calculateFee(uint amount) private pure returns (uint) {
        return amount / 100; // Internal fee logic
    }
}
```

## 2. internal

### Variables

- **Access**: Accessible in the defining contract and any contract that inherits it. Default for state variables if no specifier is provided.
- **Use Case**: Useful for data shared across a contract family, like token supply in a base contract.


### Functions

- **Access**: Callable in the defining contract and derived contracts, but not externally.
- **Use Case**: Reusable logic in inheritance hierarchies, like minting or balance updates.


### Example

```solidity
contract BaseToken {
    uint internal totalSupply;

    function _mint(address to, uint amount) internal {
        totalSupply += amount;
    }
}

contract MyToken is BaseToken {
    function mint(address to, uint amount) public {
        _mint(to, amount); // Accessible due to internal visibility
    }
}
```

## 3. public

### Variables

- **Access**: Accessible from anywhere: within the contract, derived contracts, and externally. Solidity auto-generates a getter function for public variables.
- **Use Case**: Expose data for transparency, like token balances or configuration settings.


### Functions

- **Access**: Callable from anywhere: internally, in derived contracts, or externally.
- **Use Case**: User-facing functions, like transferring tokens or approving spenders.


### Example

```solidity
contract Token {
    mapping(address => uint) public balances; // Auto-generates balances(address) getter

    function transfer(address to, uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}
```

**Note**: You can't directly set a public variable from another contract (e.g., `token.balances[addr] = 100`). Use a public setter function instead.

## 4. external

### Variables

- **Access**: Not applicable. Variables cannot have external visibility in Solidity.


### Functions

- **Access**: Only callable from outside the contract. Not callable internally unless using `this.functionName()` (which is gas-inefficient and rare).
- **Use Case**: Functions meant for external interaction, like token transfers in specific contexts. Slightly cheaper than public for external calls due to optimized call handling.


### Example

```solidity
contract Token {
    function updateBalance(address to, uint amount) external {
        // Logic for external balance updates
    }
}
```

## Comparison: Variables vs. Functions

| Specifier | Variables | Functions | ERC-20 Use Case |
|-----------|-----------|-----------|----------------|
| `private` | Only in defining contract. Not inherited or external. | Only in defining contract. Not inherited or external. | Private fee calculations or temporary variables. |
| `internal` | In defining contract and derived contracts. Default for variables. | In defining contract and derived contracts. | Internal `_mint` or `_burn` functions; internal supply tracking. |
| `public` | Anywhere (getter generated). | Anywhere (internal, derived, external). | Public balances mapping; `transfer`, `approve` functions. |
| `external` | Not applicable. | Only external (not internal without `this.`). | `transferFrom` (if gas optimization is prioritized). |

## Practical Notes

- **Security**: Use `private` or `internal` for sensitive data (e.g., admin keys) or logic to reduce attack surfaces. Public variables expose data via getters, so use cautiously.
- **Gas Efficiency**: `external` functions save gas for external calls compared to `public`. For variables, public getters add minor gas overhead.
- **Conventions**: Prefix internal or private functions with `_` (e.g., `_mint`) to signal they're not user-facing.
- **ERC-20 Context**: In tokens like USDC or DAI, `public` is used for balances and allowances to enable transparency, while `_mint` and `_burn` are internal to restrict minting/burning to authorized contracts.