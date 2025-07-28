# Inheritance in Solidity

## What is Inheritance?

Inheritance is a powerful concept in Object Oriented Programming (OOP). The best way to reason about inheritance in programming is to think of it as a way by which pieces of code "inherit" data and functions from other pieces of code by importing and embedding them.

Inheritance in Solidity also allows a developer to access, use and modify the properties (data) and functions (behaviour) of contracts that are inherited from.

## Key Terminology

- **Derived Contract / Child Contract / Subclass**: The contract that receives this inherited material
- **Parent Contract**: The contract whose material is made available to one or more derived contracts

## Basic Inheritance Syntax

You can spot a child contract and identify its parent contract by looking for the `is` keyword.

```solidity
contract A {
    string constant A_NAME = "A";
    
    function getName() public view returns (string memory) {
        return A_NAME;
    }
}

contract B is A {
    string constant B_NAME = "B";
    // Contract B now has access to A_NAME and getName() from Contract A
}
```

## Multiple Inheritance

Unlike some programming languages like Java, Solidity allows for multiple inheritance. Multiple inheritance refers to the ability of a derived contract to inherit data and methods from more than one parent contract. In other words, one child contract can have multiple parents.

```solidity
contract A { /* ... */ }
contract B { /* ... */ }
contract C is A, B {
    // Contract C inherits from both A and B
}
```

## Function Overriding

### Virtual and Override Keywords

To modify inherited functions, Solidity uses two important keywords:

- **`virtual`**: This modifier allows the function to be "overridden" in a child contract that inherits from it. In other words, a function with the keyword virtual can be "rewritten" with different internal logic in another contract that inherits from this one.

- **`override`**: This is the flip side to the virtual modifier. When a child contract "rewrites" a function that was declared in a base contract (parent contract) from which it inherits, it marks that rewritten function with override to signal that its implementation overrides the one given in the parent contract.

```solidity
contract A {
    function getName() public virtual returns (string memory) {
        return "A";
    }
}

contract B is A {
    function getName() public pure override returns (string memory) {
        return "B";
    }
}
```

### Function Overloading vs Overriding

When functions have identical names but different arguments, it's not an override, but an overload. And there is no conflict because the methods have different arguments, and so there is enough information in their signatures to show the compiler that they're different.

```solidity
contract B is A {
    // This is overloading, not overriding (different signature)
    function getName(string memory prefix) public pure returns (string memory) {
        return string(abi.encodePacked(prefix, "B"));
    }
}
```

## State Variables and Inheritance

### Variable Shadowing Restrictions

State variables in child contracts cannot have the same name and type as their parent contracts. This would cause a "shadowing" error.

```solidity
contract A {
    string author = "Zubin";
}

contract B is A {
    // This will cause a compiler error (shadowing)
    // string author = "Someone else";
}

contract C is A {
    // This is correct - different name
    string bookAuthor = "Hemingway";
    
    constructor() {
        author = "Hemingway"; // Overriding the value
    }
}
```

## Inheritance Hierarchy

Which version of a function will be called if a function by the same name and signature exists in a chain of inheritance? The answer is the last one – the "most derived" implementation in the contract hierarchy.

For inheritance chain A → B → C → D → E, if all contracts have the same function, the implementation in contract E will be called.

## Constructor Inheritance

When parent contracts have constructors with parameters, child contracts must provide those arguments. There are two methods:

### Method 1: Pass arguments in inheritance declaration
```solidity
contract Parent {
    constructor(string memory _name) {
        // Constructor logic
    }
}

contract Child is Parent("ChildName") {
    // Child constructor
}
```

### Method 2: Pass arguments in child constructor
```solidity
contract Child is Parent {
    constructor(string memory _childName) Parent(_childName) {
        // Child constructor logic
    }
}
```

## Modifier Inheritance

Modifiers are also inheritable.

```solidity
contract A {
    address owner;
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }
}

contract B is A {
    function restrictedFunction() public onlyOwner {
        // This function can use the inherited modifier
    }
}
```

## Contract Compilation and Deployment

When a contract inherits from one or more parent contract, only one single (combined) contract is created on the blockchain. The compiler effectively compiles all the other contracts and their parent contracts and so on up the entire hierarchy all into a single compiled contract (which is referred to as a "flattened" contract).

## Benefits of Inheritance

1. **Code Reuse**: Inheritance facilitates convenient and extensive code reuse – imagine a chain of application code that inherits from other code, and those in turn inherit from others and so on.

2. **Modularity**: Allows breaking down complex contracts into smaller, manageable components

3. **Upgradability**: Provides a foundation for creating upgradeable contract patterns

4. **DRY Principle**: Follows "Don't Repeat Yourself" by allowing common functionality to be written once and inherited

## Best Practices

1. **Mark functions as `virtual`** if you want child contracts to be able to override them
2. **Use `override`** when implementing or changing inherited functions
3. **Be careful with state variable naming** to avoid shadowing errors
4. **Plan your inheritance hierarchy** carefully to avoid diamond problem complexities
5. **Consider gas optimization** when designing inheritance chains, as deeper hierarchies can increase deployment costs

## Common Use Cases

- **Access Control**: Base contracts with role-based permissions
- **Token Standards**: ERC20, ERC721 base implementations
- **Upgradeable Contracts**: Proxy patterns using inheritance
- **Shared Utility Functions**: Common mathematical or validation functions
- **Template Contracts**: Standard contract structures that can be customized

## Abstract Contracts vs Inheritance

While related to inheritance, abstract contracts serve as templates that cannot be deployed directly but must be inherited from. They're useful for defining interfaces that child contracts must implement.

```solidity
abstract contract BaseContract {
    function mustImplement() public virtual;
    
    function implemented() public pure returns (string memory) {
        return "This is implemented";
    }
}

contract ConcreteContract is BaseContract {
    function mustImplement() public pure override {
        // Must implement this function
    }
}
```

## Conclusion

Inheritance in Solidity is a powerful feature that enables code reuse, modularity, and the creation of complex contract systems. By understanding the proper use of `virtual`, `override`, and inheritance syntax, developers can build maintainable and efficient smart contract architectures while avoiding common pitfalls like variable shadowing and improper function overriding.