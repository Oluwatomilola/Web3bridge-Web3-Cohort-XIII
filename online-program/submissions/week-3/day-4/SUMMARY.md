### Summary

In summary, I learned what Solidity is and how it handles different types of data. **Value types** store actual data and are copied when used. These include:

- `bool` (true or false)  
- `int` and `uint` (for numbers)  
- `address` (for Ethereum addresses)  
- `bytes` (fixed-size binary data)  
- `string` (text)  
- `enum` (custom options)

On the other hand, **reference types** store a pointer to the data, meaning changes to one variable can affect another if they point to the same place. These include:

- `arrays`  
- `strings`  
- `structs` (custom data groups)  
- `mappings` (key-value pairs)


### About Smart Contract

I learned what a smart contract is and how its structure works in Solidity. A smart contract is like a program stored on the blockchain. It holds both data (called **state variables**) and logic (called **functions**).

Some key things I learnt from the sample smart contract that was used in class were:

- **SPDX-License Identifier**: A comment at the top that mentions the license type (not required, but recommended).
- **Pragma**: Tells the Solidity compiler which version to use.
- **Semicolons** are mandatory in Solidity.
- **Contracts** in Solidity are similar to classes in other languages. They bundle variables and functions together.
- **State variables** are stored on the blockchain.
- **Functions** define actions the contract can take. Functions have return types and can be visible to the public or private to the contract.

---

### I also learned about variable scope in Solidity:

- **State variables**: Stored permanently on the blockchain.
- **Local variables**: Exist temporarily during function execution.
- **Global variables**: Built-in values provided by Solidity, like block time or sender address.

---

### Then I learned about visibility specifiers:

- `public`: Anyone can access (inside or outside the contract).
- `private`: Only within the same contract.
- `internal`: Same contract or child contracts.
- `external`: Can only be called from outside the contract.

---

### Then in Constructors:

I learned about constructors to be:

- A **constructor** is a special function that runs once when the contract is created.
- It helps set up initial values or configurations.
- After deployment, constructor code is **not stored** on the blockchain.

### About Contract State

I learned that the **contract state** in Solidity refers to the data that is **permanently stored on the blockchain**.

This data is kept in **state variables**, which are written inside the contract. These variables keep their values even after functions run, as long as the contract is not removed.

- **State variables** hold important information about the contract.
- They are saved on the blockchain and **can change** when functions update them.
- Changing state variables means you are **changing the contract’s data**, and this action usually uses gas.


