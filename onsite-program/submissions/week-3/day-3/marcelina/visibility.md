Visibility Specifiers in Solidity

In Solidity, visibility specifiers define the scope and accessibility of functions and state variables. These specifiers determine whether a function or variable can be accessed from within the same contract, derived contracts, or external contracts and users.

There are four types of visibility specifiers in Solidity:

Private

Internal

Public

External

Each specifier serves a different purpose and is important for encapsulation, inheritance, and security.

1. Private
The private visibility specifier restricts access to functions or variables so that they can only be used within the contract in which they are declared. They cannot be accessed by child contracts or external calls.

Example
contract Bank {
    uint private balance = 1000;

    function getBalance() private view returns (uint) {
        return balance;
    }
}

2. Internal
The internal specifier allows access within the same contract and also in derived contracts (contracts that inherit from the parent).

Example
contract Parent {
    uint internal data = 50;

    function multiply() internal view returns (uint) {
        return data * 2;
    }
}

contract Child is Parent {
    function getResult() public view returns (uint) {
        return multiply(); // Access is allowed here
    }
}
Child contract inherits from Parent and has access to the internal function and variable.

3. Public
The public specifier allows access from anywhere — within the same contract, from derived contracts, and from external accounts. For state variables, Solidity automatically creates a getter function.

Example
contract Counter {
    uint public count = 0;

    function increment() public {
        count += 1;
    }
}
External users can both view count and call increment().

4. External
Definition
The external visibility specifier makes functions only callable from outside the contract. These functions cannot be accessed internally unless called using this.functionName().

Example
contract Greeter {
    function greet() external pure returns (string memory) {
        return "Hello, world!";
    }

}
You can only call greet() from an external account or contract.