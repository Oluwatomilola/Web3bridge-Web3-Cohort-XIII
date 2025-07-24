# The Different Variables and Function (Vis-a-Vis) Visibility Specifiers in Solidity

Visibility means something or an object that's easily observable. In Solidity, it implies transparency of various parts of a smart contract or a piece of code thereby making these parts accessible by another piece of code or program.

## Solidity Visibility Specifiers

A variable in Solidity is a container, state or value holder that when initialized, causes a change to that smart contract (e.g transactions, signing, or any other task that can be done on a smart contract).

A function is an executable piece of code that performs a task once called. The function holds variables known as state values, and returns a value of any type (available in solidity) as a response after its execution.

In solidity, there are **4 different visibility specifiers** and they affect both functions and variables alike. They determine the extent to which a function or variable can be accessed from outside the region of code where it was is initialized.

There are:

1. **public** visibility specifier

2. **private** visibility specifier

3. **external** visibility specifier

4. **internal** visibility specifier

### Public Visibility Specifier

In solidity, variables and functions that are specified as publicly visible are accessible anywhere in the contract they were declared in, and also outside by other contracts.

They are declared with a  `public` keyword, and this signifies to the compiler that their scope should be made global within the contract.

**NOTE:** When a storage variable is given public visibility, Solidity automatically creates an implicit getter function for that variable's value which can be used by other contracts to interact with that public variable.

### Private Visibility Specifier

In Solidity, variables and functions that are specified as `private` are only accessible within the contract they are defined in. They cannot be accessed by other contracts, even if they inherit from the contract. This makes `private` the most restrictive visibility specifier, as it limits the scope of the variable or function to the current contract only.

### Internal Visibility Specifier

The `internal` visibility specifier in Solidity is similar to `private`, but it has a slightly broader scope. Variables and functions marked as `internal` can be accessed within the current contract and also by any contracts that inherit from it. However, they cannot be accessed by other contracts that do not inherit from the current contract.

### External Visibility Specifier

The `external` visibility specifier in Solidity is the most restrictive for functions, as it indicates that the function can only be called from outside the contract, not from within the contract itself. This can be useful for functions that are meant to be entry points for the contract, but should not be called internally. Variables cannot be marked as `external`; they can only be `public`, `private`, or `internal`.