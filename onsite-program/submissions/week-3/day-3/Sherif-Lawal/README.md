# Web3bridge Web3 Cohort XIII - Sherif Lawal Week3, Day 2 Submission

# Visibility specifiers in Solidity as they relate to variables and functions

I set out to discuss different visibility specifiers in solidity as they relate to variables and functions. According to [freecodecamp](https://www.freecodecamp.org/news/learn-solidity-handbook/#heading-how-to-declare-variables-and-functions-in-solidity), in Solidity, visibility means "the ability of a piece of code to be seen and accessed by another piece of code". How I understand this is, visibility in solidity refers to how a piece of code is seen and accessible by another piece of code. These visiibilities are basically attributed to variables or functions to determine how these variables or functions can be seen and accessed. There are just four (4) visibility specifiers in Solidity and they are: public, internal, external, and private.

```bash
    Public functions and variables can be accessed in:
    1. Inside the contract
    2. Outside the contract
    3. From other smart contracts
    4. From external accounts... basically, can be accessed everywhere.
```

    ### For example  `string public publicVar = "I am public";

        Here, this is a variable with the name publicVar.
        That variable is a string.
        That variable can be accessed everywhere.

---

```bash
    Private functions and variables can be accessed in:
    1. Only within the smart contact that declares them.
```

    ### For example  `string private privateVar = "I am private";

        Here, this is a variable with the name privateVar.
        That variable is a string.
        That variable can only be accessed within the smart contract.

---

```bash
    Internal functions and variables are similar to private visibility can be accessed in:
    1. Only within the smart contact that declares them.
    2. They can also be accessed from deived contacts (e.g child contracts)
```

    ### For example  `string internal internalVar = "I am internal";

        Here, this is a variable with the name internalVar.
        That variable is a string.
        That variable can only be accessed within the smart contract or within SCs that inherit from the SC where they are declared..

---

```bash
    External functions can be called from:
    1. Outside of the contract where they are being declared.
    2. They can only be applied to functions and not variables.
```

    ### For example  `function getExternalMessage() external;

        Here, this is a function with the name getExternalMessage.

---

Here is a code sample which I will be making reference to throughoutt this assessment.

`
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    contract VisibilityContract {
    string public name = "Sherif";
    uint256 private age = 12;
    bool internal isActive = true;

        function getName() public view returns (string memory) {
            return name;
        }

        function getAge() private view returns (uint256) {
            return age;
        }

        function revealAge() public view returns (uint256) {
            return getAge();
        }

        function checkStatus() internal view returns (bool) {
            return isActive;
        }

        function status() public view returns (bool) {
            return checkStatus();
        }

        function greet() external pure returns (string memory) {
            return "Hello from external function";
        }

    }

`

## In the example above, here are things you need to note:

    -   the name variable can be accessed inside the VisibilityContract smart contract and even outside. i.e if there is another SC, it can be accessed there. Same as the getName function because it is public.
    -   The age can only be accessed only within this smart contact. Same as the getAge function because it is private.
    -   The isActive which is meant to show if I am active or not can be accessed within this VisibilityContract and outside because it is internal.

    -   Now, the greet() function is external which means it cannot be accessed within this VisibilityContract but only outside.

```
### Reference

    [Freecodecamp](https://www.freecodecamp.org/news/learn-solidity-handbook/#heading-how-to-declare-variables-and-functions-in-solidity)

Thank you for reading!
```
