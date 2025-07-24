Visibility Specifiers As Regards Variables and functions


Visibility specifiers in Solidity define the accessibility of variables and functions in a contract.

There are four types of visibility specifiers in Solidity, and these specifiers control whether variables and/or functions elements can be accessed internally, externally, or by derived contracts.

These specfiers include: public, private, internal, and external.


Visibilty Specifiers for Variables


Public: They are accessible from within the contract, derived contracts, and externally.They automatically generates a getter function for external access.

Private: They are only accessible within the contract where they are defined.They are not accessible in derived contracts or externally.

Internal: They are accessible within the contract and in derived contracts.They are not externally accessible.

External: They are not applicable to variables. Variables cannot be declared as external.


Visibilty Specifiers for Functions


Public: They can be called from within the contract, derived contracts, and externally.

Private: They are only callable within the contract where defined.They are not accessible in derived contracts or externally.

Internal: They are callable within the contract and in derived contracts.They are not callable externally.

External: They are only callable from outside the contract. They are not callable internally or from derived contracts unless by using "this" keyword.


Note that when visibility isnt specified explicitly for variables, in Solidity variables are implicitly set to internal by default. And when visibility isnt specified explicitly for functions, they are implicitly set to public by default.