# Summary: Visibility Specifiers in Solidity

In Solidity, visibility specifiers define where functions and state variables can be accessed from. There are four types of visibility specifiers in solidity:

# 1. Public: 
 Public is the most open visibility specifier in solidity, anything marked public can be accessed anywhere from inside the same contract, from inherited contracts, and also from external contracts. Solidity automatically declares a variable public if the visibility is not specified.



# 2. Private: 
This is the most restricted visibility in solidity. A function or variable with the specifier of private can only be used and accessed inside the contract where it was defined. It cannot be accessed by a derived contracts or externally. It is useful for keeping sensitive data hidden.



#3. Internal: This is similar to private but slightly more flexible. Here, an internal function or variable can be accessed from inside the same contract, and a derived contract can also access a function or variable with a specifier of internal. Internal functions or variables cannot be accessed externally.


#4. External: This can only be used with functions and not variables. It can be called from outside the contract which it was defined in adn cannot be accessed or called internally like a normal function. 



# Summary Notes

- Use public when you want external and internal access.
- Use private for internal-only access with no inheritance.
- Use internal for access within the contract and derived contracts.
- Use external when the function is meant to be called only from outside the contract (like APIs).

