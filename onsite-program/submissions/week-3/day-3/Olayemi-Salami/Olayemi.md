 ### SUMMARY OF SOLIDITY VISIBILITY SPECIFIERS.

 **Visibility specifiers** define **how and where** state variables and functions can be accessed. They help control the **security**, **accessibility**, and **behavior** of a contract.

### The 4 Visibility types in Solidity are:
- `Public`
- `External`
- `Internal`
- `Private`

---
- `Public`: The Public visibility allows maximum accessibility by everyone. Both internal (within the same contract and derived contracts) and external (outside contracts and external users via transactions) entities can access public functions and variables.

- `External`: The external visibility is used only for functions (not variables). Functions marked as external can be called from outside the contract only either through transactions or by other contracts. This specifier is generally used to optimize for external access, especially in contracts designed to interact with users or other smart contracts.

- `Internal`: The internal visibility restricts access to only the current contract and contracts that inherit from it. It is the default visibility for functions and variables if no specifier is explicitly defined. The functions and variables marked as internal are not accessible externally, meaning they cannot be invoked through transactions or by unrelated contracts. This specifier is typically used for reusable logic or internal data structures meant to be inherited and reused in child contracts.

- `Private`: The private visibility is the most restrictive. Functions and variables marked as private are only accessible within the contract in which they are defined. Even derived (inheriting) contracts cannot access them. This specifier is ideal for ensuring that sensitive logic or data cannot be altered or accessed from outside the contract's own scope. It promotes strong encapsulation and protects against unintentional interaction or misuse.
