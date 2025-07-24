#Assignment

DIFFERENT VISIBILITY SPECIFIERS IN SOLIDITY

Visibility specifiers control access to the variables and functions they are declared on.

There are four main visibility specifiers in solidity:

- Public
- Private
- Internal
- External

Function Visibility Specifiers

1. Public Functions: These functions are part of the contract's ABI and can be called from anywhere(internally and externally) including other contracts or external accounts. They are acceessible through transaction calls and contract-to-contract calls. It is useful to specify public visibility for main contract interface functions and functions that need to be accessible by users and other contracts.

2. Private Functions: Unlike public functions that can be called from anywhere, these are not part of the contract's ABI and are only accessible within the same contract. They also can't be inherited by derived contracts. Specifying private visibility on a function provides the highest level of restriction and is useful for internal helper functions and sensitive operations that should not be exposed.

3. Internal Functions: These are accessible within the same contract and its derived contracts but cannot be accessed from external contracts or accounts. Like the private function, it isn't part of the contract's ABI. It is useful when dealing with functions that are shared betweeen parent and child contracts and other common utility functions for contract families.

4. External Functions: Externals are only callable from outside the contract and are part of the contract's ABI. They cannot be called internally except using a self-reference in the format this.functionName(). They are useful in main entry points for external interactions and gas optimization functions with large parameters.


Variable Visibility Specifiers

1. Public Variables: These variables, like public functions, are part of the contract's ABI and are accessible from anywhere. They can be read by external contracts and accounts. When a variable is given public visibility, Solidity automatically creates a getter function for that variable's value.

2. Private Variables: Although they can still be read by examining contract storage directly, private variables are only accessible within the same contract and can't be inherited by derived contracts. This is the most restrictive access level for a variable. 

3. Internal Variables: These are accessible within the same contract and derived contracts. This is the default visibility for variables.

External visibility doesn't apply to variables.

