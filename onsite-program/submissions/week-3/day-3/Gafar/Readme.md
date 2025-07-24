# 🔐 Solidity Visibility Specifiers

**Solidity**, the primary programming language for Ethereum smart contracts, uses **visibility specifiers** to control access to variables and functions. These specifiers define **where and how** the components of a contract can be accessed.

There are **four visibility specifiers for functions** in Solidity:

- `public`
- `private`
- `internal`
- `external`

---

## 1. 🔓 Public

### 🔸 Variables:
- Accessible **everywhere**: within the contract, derived (child) contracts, other external contracts, and via external transactions.
- Automatically generates a **getter function** to allow external read access.
- Can be **read or written to** by anyone, unless additional restrictions (e.g., `require` statements) are added.

### 🔸 Functions:
- Callable **internally** (within the same contract), by **derived contracts**, and **externally** (by transactions or other contracts).
- Useful for logic intended to be accessible by any user or system.

### ✅ Use Cases:
- **Variables**: When you want public read access to data (e.g., balances).
- **Functions**: For core functionality meant for public interaction.

### 📦 Example:
```solidity
uint public myVar = 10; // Accessible everywhere, auto-generates getter

function myFunction() public returns (uint) {
    return myVar; // Callable by anyone
}
```

---

## 2. 🔒 Private

### 🔸 Variables:
- Only accessible **within the contract** where declared.
- **Not** accessible from derived contracts or external actors.
- Provides the **highest level of encapsulation**.

### 🔸 Functions:
- Only callable **within the same contract**.
- **Not accessible** by child contracts or external users.
- Ideal for **internal helper functions** or **sensitive logic**.

### ✅ Use Cases:
- **Variables**: Storing private keys, counters, or sensitive flags.
- **Functions**: Logic that must not be exposed, e.g., internal checks or utilities.

### 📦 Example:
```solidity
uint private secretVar = 42; // Only accessible in this contract

function privateFunction() private returns (uint) {
    return secretVar; // Only callable within this contract
}
```

---

## 3. 🛡️ Internal

### 🔸 Variables:
- Accessible **within the same contract** and **in derived contracts**.
- Not accessible from external contracts or external transactions.
- Similar to `protected` in other OOP languages.

### 🔸 Functions:
- Callable from the current contract and any **inheriting contract**.
- **Not** callable externally.

### ✅ Use Cases:
- **Variables**: Shared state like internal configurations or base settings.
- **Functions**: Common reusable logic across inherited contracts.

### 📦 Example:
```solidity
uint internal sharedVar = 100; // Accessible in this and derived contracts

function internalFunction() internal returns (uint) {
    return sharedVar; // Callable in this and derived contracts
}
```

---

## 4. 🌐 External

### 🔸 Variables:
- ❌ **Not applicable**. You **cannot** declare state variables as `external`.
- Attempting to do so will result in a **compilation error**.

### 🔸 Functions:
- Can only be called **externally** (via transactions or from other contracts).
- **Cannot** be called internally unless using `this.functionName()` (which incurs additional gas costs).

### ✅ Use Cases:
- Functions meant to be entry points for users or external smart contracts (e.g., DApps, token transfers).

### 📦 Example:
```solidity
function externalFunction() external returns (uint) {
    return 200; // Only callable externally
}
```

---

## ⚙️ Key Considerations

| Area               | Notes                                                                 |
|--------------------|-----------------------------------------------------------------------|
| **Gas Efficiency** | `external` functions are more optimized for external calls than `public`. |
| **Security**       | Use `private` or `internal` for sensitive logic to reduce attack surface. |
| **Inheritance**    | `internal` is key for inheritance while hiding logic from external actors. |
| **Default Visibility** | In older versions (pre-0.5.0), functions default to `public`. State variables default to `internal`. |

---

## 📊 Summary Table

| **Specifier** | **Variables**                        | **Functions**               | **Accessible By**                                       |
|---------------|--------------------------------------|-----------------------------|---------------------------------------------------------|
| `public`      | Everywhere (getter auto-generated)   | Everywhere                  | This contract, derived contracts, external calls        |
| `private`     | Only this contract                   | Only this contract          | Only this contract                                      |
| `internal`    | This + derived contracts             | This + derived contracts    | This and derived contracts                              |
| `external`    | ❌ Not applicable                     | Only external calls         | Other contracts or external transactions only           |

---

This overview aligns with Solidity **version 0.8.x** and provides foundational knowledge for writing secure and maintainable smart contracts.
