# Solidity Inheritance Summary
Inheritance in Solidity allows one contract to acquire properties and behaviors (functions, state variables) from another contract. Solidity supports multiple inheritance, meaning a single contract can inherit from more than one parent contract.

## Key Concepts

### Basic Inheritance
- Solidity supports multiple inheritance using the `is` keyword
- Child contracts inherit all public and internal functions, state variables, and modifiers from parent contracts
- Inheritance creates an "is-a" relationship between contracts

### Function Overriding Rules
- **Parent functions** that can be overridden must be marked as `virtual`
- **Child functions** that override parent functions must use the `override` keyword
- When overriding functions from multiple parents, specify all parent contracts: `override(Parent1, Parent2)`

### Inheritance Order - Critical Rule
- Parent contracts must be listed from "most base-like" to "most derived"
- This follows the C3 linearization algorithm
- Incorrect ordering will cause compilation errors

## Method Resolution Order (MRO)

When a function exists in multiple parent contracts, Solidity searches:
1. **Right to left** through the inheritance list
2. **Depth-first** manner through the inheritance hierarchy

### Example from the code:
```solidity
contract D is B, C {  // C is rightmost
    function foo() public pure override(B, C) returns (string memory) {
        return super.foo();  // Returns "C"
    }
}

contract E is C, B {  // B is rightmost  
    function foo() public pure override(C, B) returns (string memory) {
        return super.foo();  // Returns "B"
    }
}
```

## The `super` Keyword

- `super.functionName()` calls the function from the next contract in the MRO
- It doesn't necessarily call the immediate parent - it follows the linearization order
- Useful for extending functionality rather than completely replacing it

## Inheritance Hierarchy Example

```
    A (base)
   / \
  B   C  
 / \ /
F  D,E (most derived)
```

### Valid inheritance declarations:
- `contract B is A` ✅
- `contract D is B, C` ✅ (B and C both derive from A)
- `contract F is A, B` ✅ (A is more base-like than B)

### Invalid inheritance:
- `contract F is B, A` ❌ (wrong order - A should come before B)

## Practical Implications

1. **Order matters**: Always list parents from most general to most specific
2. **Diamond problem**: Solidity handles multiple inheritance paths gracefully through MRO
3. **Explicit overrides**: Must specify which parent functions you're overriding when there are conflicts
4. **Super calls**: Use `super` to maintain the inheritance chain rather than calling specific parent functions

## Best Practices

- Keep inheritance hierarchies as simple as possible
- Use composition over inheritance when relationships aren't clearly "is-a"
- Always test the MRO behavior when using multiple inheritance
- Document inheritance relationships clearly for other developers