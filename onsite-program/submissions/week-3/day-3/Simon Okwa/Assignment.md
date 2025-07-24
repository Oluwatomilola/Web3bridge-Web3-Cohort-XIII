#  Visibility in Solidity

In Solidity, you can control who has access to the functions and state variables in your contract and how they interact with them. This concept is known as **visibility**.

A function’s visibility can be set to **external**, **public**, **internal**, or **private**, while state variables only have three possible visibility modifiers: **public**, **internal**, or **private**. The keyword `external` is not applicable to state variables.

---

##  External

External functions can only be called from **outside** the contract in which they were declared.

```
contract MyContract {
    function sayHello() external pure returns (string memory) {
        return "Hello from outside!";
    }
}
```

---

##  Public

Public functions and variables can be accessed by **all parties within and outside the contract**. When the visibility is not specified, the **default visibility of a function is `public`**.

```
contract MyContract {
    uint public count = 0; // Automatically creates a getter

    function increment() public {
        count++;
    }
}
```


---

##  Internal

Functions and variables declared with the `internal` keyword are only accessible **within the contract** in which they were declared, although they can be accessed from **derived contracts**. When visibility is not specified, **state variables have the default value of `internal`**.

```
contract Base {
    uint internal score = 100;

    function getScore() internal view returns (uint) {
        return score;
    }
}

contract Child is Base {
    function readScore() public view returns (uint) {
        return getScore(); // allowed because it's internal
    }
}
```

---

##  Private

Functions declared with the `private` keyword are only accessible **within the contract** in which they were declared. Private functions are also the **only functions that cannot be inherited** by other functions.

```
contract MyContract {
    string private secret = "hidden";

    function getSecret() private view returns (string memory) {
        return secret;
    }

    function reveal() public view returns (string memory) {
        return getSecret(); // allowed within the same contract
    }
}
```

> **Note**: Setting the visibility of a function or variable to `private` does **not** make it invisible on the blockchain. It simply **restricts its access** to functions within the contract.
