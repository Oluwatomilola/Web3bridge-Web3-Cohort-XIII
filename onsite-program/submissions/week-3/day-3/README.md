# Solidity Visibility Specifiers - Explained Simply

In Solidity, **visibility specifiers** control **who can access** functions or state variables. There are **four** main visibility levels:

- `public`
- `internal`
- `private`
- `external` (only for functions)

---

## 🔑 1. public

### 🔹 For Functions:

- Can be **called from anywhere**: within the contract, from derived (child) contracts, and from external accounts or contracts.
  _Example:_

```solidity
function sayHello() public pure returns (string memory) {
    return "Hello!";
}


---

## 🔑 2. private

- *Functions & Variables:* Only accessible within the contract where they are declared. Not accessible from derived contracts or externally.

*Example:*
solidity
uint private secret;

function setSecret(uint _value) private {
    secret = _value;
}


---

3. *Internal*
## 🔑 3. Internal

- *Functions & Variables:* Accessible within the contract and from derived (child) contracts. Not accessible externally.

*Example:*
solidity
uint internal data;

function updateData(uint _val) internal {
    data = _val;
}
```

---

## 🔑 4. External

- Functions only: Can be called only from outside the contract (externally). Cannot be called internally unless via this.functionName().

Example:
solidity
function callMe() external pure returns (string memory) {
return "Hello";
}

---

Summary Table

| Specifier | Contract           | Derived Contracts | External |
| --------- | ------------------ | ----------------- | -------- |
| public    | ✅                 | ✅                | ✅       |
| private   | ✅                 | ❌                | ❌       |
| internal  | ✅                 | ✅                | ❌       |
| external  | ❌ (only via this) | ❌                | ✅       |

---

✅ Created by **Maryjane Ukamaka Okafor**  
📚 Web3Bridge Cohort XIII  
🗓️ Day 3 – Solidity Visibility Assignment
