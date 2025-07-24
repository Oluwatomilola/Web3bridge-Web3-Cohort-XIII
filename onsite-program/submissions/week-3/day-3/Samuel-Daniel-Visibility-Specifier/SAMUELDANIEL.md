# Visibility Specifiers
In Solidity, visibility specifiers are used to control the accessibility of functions and state variables within smart contracts. These specifiers determine who can access these elements and from where. There are four main visibility specifiers: public, private, internal, and external. When it comes to variable there are three visibility specifiers which are, public, private and internal.

*Public:*
Public functions or variables can be accessed from outside the contract as well as from within. They are commonly used for functions that need to be accessible externally, such as entry points to the contract. One beautiful thing about solidity is that the the default visibility specifier is Public.

*Internal:*
Internal functions or variables are accessible from within the contract as well as from derived contracts. They cannot be accessed externally, i.e., outside the contract hierarchy.

*Private:*
Private functions or variables are only accessible from within the contract that defines them. They cannot be accessed from outside the contract or from derived contracts.

*External:*
In Solidity, the external visibility specifier restricts the calling of a function to external contracts and not to the same contract. It cannot be called from within the contract itself, only from outside the contract or by a third party. External visibility can only be assigned to functions and  not variables. When a function is marked as external, it is accessible from other contracts but not from within the contract that defines it. This makes it suitable for functions that need to be called by other contracts but not by the contract itself.
