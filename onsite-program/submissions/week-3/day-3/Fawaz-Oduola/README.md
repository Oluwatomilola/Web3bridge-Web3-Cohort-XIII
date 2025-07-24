##  Solidity Visibility Specifiers

Solidity provides four visibility specifiers that control how functions and state variables can be accessed.

| Specifier     | Description                                                                 | Accessible From                                | Variables | Functions |
|---------------|-----------------------------------------------------------------------------|------------------------------------------------|-----------|-----------|
| `public`      | Visible externally and internally. Generates a getter for state variables. | Contract, Inherited Contracts, External Accounts | ✅        | ✅        |
| `internal`    | Only visible inside the contract and derived contracts.                    | Contract, Inherited Contracts                  | ✅        | ✅        |
| `private`     | Only visible in the contract that defines it.                              | This Contract Only                             | ✅        | ✅        |
| `external`    | Only visible externally (via transactions or other contracts).             | Other Contracts, External Accounts             | ❌        | ✅        |

###  Function Example

```solidity
contract MyContract {
    function publicFunction() public pure returns (string memory) {
        return "public";
    }

    function internalFunction() internal pure returns (string memory) {
        return "internal";
    }

    function privateFunction() private pure returns (string memory) {
        return "private";
    }

    function externalFunction() external pure returns (string memory) {
        return "external";
    }
}
````

###  Variable Example

```solidity
contract MyContract {
    uint public publicVar = 1;
    uint internal internalVar = 2;
    uint private privateVar = 3;

    // external not allowed for variables
}
```

