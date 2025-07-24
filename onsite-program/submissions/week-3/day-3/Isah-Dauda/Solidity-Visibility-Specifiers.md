# *Visibility in Solidity*

In Solidity, you can control who has access to the functions and state variables in your contract and how they interact with them. This concept is known as visibility. We can say that visibility specifiers ensures _access-control_ which is a fundamental feature or requirment in security.

A *function’s* visibility can be set to `external,` `public,` `internal` or `private,` while state variables only have three possible visibility modifiers; `public,` `internal` or `private`. The keyword `external` is not applicable to state variables.

## Types of Visibility

- **Public**: _Public_ functions and variables can be accessed by all parties within and outside the contract. By default, when the visibility of a function is not specified, the contract assigns the _public_ visibility to it.

- **Internal**: Functions and variables declared with the _internal_ keyword are only accessible within the contract in which they were declared, although they can be accessed from derived contracts (this is where *inheritance* comes in-place). In the case of state variables, when the visibility is not specified, state variables have the default value of _internal_.

- **Private**: Functions and variables declared with the _private_ keyword are only accessible within the contract in which they were declared. _Private_ functions are also the only functions that cannot be inherited by other functions. *Note*: Setting the visibility of a function or variable to _private_ does not make it invisible on the blockchain. It simply restricts its access to functions within the contract.

- **External**: _External functions_ can only be called from outside the contract in which they were initially declared. So they cannot be call internally. Example, an _external function_ in a smart contract cannot be called from inside the declaring contract or contracts that inherit from the declaring contract, only an EOA or another contract can call it. *Note*: The _external_ visibility does not apply to variables. Only functions can be specified as _external_. Thus this makes _functions_ have 4 visibility specifiers while _state variables_ have 3 visibility specifiers.
