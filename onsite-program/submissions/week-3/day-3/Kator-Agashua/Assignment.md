# Solidity Visibility Specifiers

Visibility specifiers in Solidity are unique keywords that define the accessibility of functions and state variables within a smart contract. They're crucial for enhancing the security and design of your smart contracts.

---

## Understanding Visibility Specifiers

Solidity offers four primary visibility specifiers that control how variables and functions are accessed and used:

* **Public**
* **Private**
* **Internal**
* **External**

---

## Visibility Specifiers and Functions

* **Public:** Public functions can be accessed both externally and internally. They can also be called from **child contracts** (inherited contracts).

* **Private:** Private functions are **only accessible** within the declaring smart contract.

* **Internal:** Internal functions are accessible only within the declaring smart contract and **child contracts**. This is the **default visibility** when no specifier is explicitly given to a function.

* **External:** External functions are **only accessible from outside** the declaring smart contract. They can be called internally using the `this` keyword (e.g., `this.function()`).

**Example of a function with its specifier:**

```solidity
function store(uint256 _favoriteNumber) public {
    favoriteNumber = _favoriteNumber;
}

### Visibility Specifiers and State Variables

* **Public:** Public state variables are accessible both internally and externally (providing read access). They're also accessible in contracts inheriting from the parent contract. Solidity automatically creates a **getter function** for public state variables.
* **Private:** Private state variables are **only accessible** within the declaring smart contract.
* **Internal:** Internal state variables are the **default visibility** when no specifier is assigned. They're accessible only within the declaring smart contract and **child contracts**.
* **External:** The **`external` specifier is not applicable to state variables**.

**Declaration format for state variables in Solidity:**
`Type    Visibility specifier    name;`
**Example:**

```solidity
uint    public    favNumber;