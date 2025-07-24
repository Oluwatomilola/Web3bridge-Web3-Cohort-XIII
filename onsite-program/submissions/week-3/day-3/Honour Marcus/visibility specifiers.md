 Solidity Visibility Specifiers

Solidity uses four visibility specifiers to control access to variables and functions in a smart contract. Each specifier defines who can access the data or function and where it can be used.

## 1. Public
**Who can access:**
- Inside the contract
- Child (derived) contracts
- External contracts (e.g., web apps like frontends)
- Anyone on the blockchain

**Purpose:**
Automatically generates a getter function for state variables. Ideal for exposing data or functions to external users or contracts.

**Example:**
```solidity
uint public age; // Anyone can read this
function getAge() public view returns (uint) {
    return age;
}
```

## 2. Private
**Who can access:**
- Only within the same contract
- Not accessible in child contracts or externally

**Purpose:**
Hides sensitive data or internal logic, keeping them strictly internal to the contract.

**Example:**
```solidity
string private password;
function setPassword(string memory _pass) private {
    password = _pass;
}
```

## 3. Internal
**Who can access:**
- Within the same contract
- Child contracts that inherit from it

**Purpose:**
Restricts access to the contract and its derived contracts, similar to the "protected" keyword in object-oriented languages like Java or C++.

**Example:**
```solidity
uint internal balance;
function updateBalance(uint _value) internal {
    balance = _value;
}
```

## 4. External (Functions Only)
**Who can access:**
- Only from outside the contract
- Cannot be called directly within the same contract

**Purpose:**
Designed for functions called by other contracts or frontends (e.g., DApps). Saves gas compared to public functions when called externally.

**Example:**
```solidity
function ping() external pure returns (string memory) {
    return "pong";
}