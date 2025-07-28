Solidity is a statically typed language. This means that variable types have to be specified always. Some data types have a default zero value, for instance a boolean has a default value of zero.

## Value Type Variables in Solidity are listed below as:
There are two types of value type variables
a. The primitive types:
1. Boolean
2. Integer
3. Address
4. Bytes and so on

b. The Reference types:
1. structs
2. Mappings
3. Arrays and 
4. Strings

- Error handling is done by using the keywords, require, assert or revert
- Function Modifiers are used to automatically check a condition prior to execution. To create a modifier we use the syntax:
modifier modifier_name{
    //action
}
- A view function is a read only function
- A Pure function do not read or modify but are basically like helper functions
- Adding the keyword "Payable" to a function makes it able to accept ether


## Abstract Contracts are contracts with at least one uninvoked function