# Article on Solidity

## What is Solidity as a Language

Solidity is a statically typed language, which means that the type of each variable must be specified, similar to Rust or TypeScript. For solidity, the declared types have default values called "zero states," with the default for most variables being zero, except for boolean which defaults to false.

Solidity has both "value types" and "reference types." Value types store their own data and are passed by value, meaning they are copied when used in function arguments or assignments.

Boolean and Integer as examples of value types in Solidity. A boolean stores true or false values with a default of false, while integer types are used to store numerical values, including signed integers.Unsigned integers only hold positive values, while signed integers can hold both positive and negative values.

Another value type in solidity is address, which used to hold a 20-byte value representing an Ethereum wallet address. This can be used to get or transfer balances.

There are differences between bytes and strings. Bytes store a fixed-sized character set and are less expensive in smart contracts compared to strings, which can store character sets equal to or more than a byte.

However, strings have dynamic lengths and consume more gas when transported from the front end to the smart contract, making bytes preferable for data with known lengths due to their lower gas consumption.
