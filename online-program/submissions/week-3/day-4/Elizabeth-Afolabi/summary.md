# Summary of what I learnt in Class on Solidity for Week 3 Day 3
    We were taught Solidity data types, What Solidity is, composition of smart contracts, Variables and functions and how to deploy them, Error handling, Scopes, visibility specifiers, interface and abstract contracts.

--- 
## Solidity
Solidity is an object oriented programming language made from C++, JavaScript and python. It runs on Ethereum Virtual Machine and it compiles human readable code to bytecode.

---

## Solidity Data types
Just as we have data types in JavaScript, Solidity also has its own. But Solidity does not have the types undefined or null, instead, if you make a new variable and don’t give it a value, Solidity gives it a default value which depends on its type.

### Value Types vs. Reference Types
Value types like numbers, booleans, addresses get COPIED when you use them while Reference types like arrays and structs are SHARED i.e you both point to the same thing.
Examples of value types - uint(Numbers that can’t be negative), int (numbers that can be negative), address, bool and bytes

##### There are data types referred to as composite data types because they are composed from other primitive data types - structs and mappings
Structs gives the ability to define a custom type so that can be used to  organize and collect pieces of data into one larger data type.
mapping in Solidity is a key-value store where each key maps to a value, providing constant-time lookup. It cannot be iterated or passed as parameters externally.

---

## Smart contracts
We looked into smart contract with an example and what smart contract codes mean. e.g
// SPDX-License-Identifier: MIT -> This line specifies the License of the contract code
pragma solidity ^0.8.8.0; -> This is compulsory and it must be the first line of code in every solidity file because it tells the EVM which compiler version to use in compiling.

contract HotFudgeSauce {
    uint public qtyCups;

    // Get the current hot fudge quantity
    function get() public view returns (uint) {
        return qtyCups;
    }

    // Increment hot fudge quantity by 1
    function increment() public {
        qtyCups += 1; // same as  qtyCups = qtyCups + 1;
    }

    // Function to decrement count by 1
    function decrement() public {
        qtyCups -= 1; // same as  qtyCups = qtyCups - 1;
        // What happens if qtyCups = 0 when this func is called?
    }
}
- the keyword contract informs EVM that it's compiling a smart contract
- semicolons are very important in solidity

## Constructors
A constructor in Solidity is a special function that runs only once when a smart contract is created. It is used to set initial values for the contract’s variables at deployment time, making the contract configurable. When the constructor runs, its code is not included in the final deployed contract. 