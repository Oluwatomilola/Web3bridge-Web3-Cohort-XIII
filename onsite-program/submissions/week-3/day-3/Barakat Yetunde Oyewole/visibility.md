# Solidity Visibility Specifiers
## Public:
- Variables: Anyone can read them, from inside the contract, other contracts, or outside. Gets an auto-read function.
- Functions: Callable from anywhere—inside, inherited contracts, or outside.
- Use: Stuff you want everyone to see or use.

## Private:
- Variables: Only usable in the contract they're in. No outside or inherited access.
- Functions: Only called inside the same contract, nowhere else.
- Use: Keep sensitive stuff hidden.

## Internal:
- Variables: Usable in the contract and any contracts that inherit from it. No outside access.
- Functions: Callable in the contract or its kids, not outside.
- Use: Share with child contracts.

## External:
- Variables: Can't use for variables.
- Functions: Only callable from outside (like other contracts or transactions), not inside unless you do some extra work.
- Use: Save gas for stuff only needed externally.

## Key Points:
Defaults: Variables are internal, functions are public if you don’t say otherwise. Always be clear.

Gas: public costs more gas; private and internal are cheaper.

Security: Use private for secrets, internal for inheritance, external for outside-only calls.

Your Project: In your Storage contract, a public variable like number can be read by anyone on the CoreDAO testnet.