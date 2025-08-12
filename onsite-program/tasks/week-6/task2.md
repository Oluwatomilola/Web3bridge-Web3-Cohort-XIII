## Task — Implement off-chain signing (EIP-712) to permit a Uniswap swap

### Goal:
Allow a user to approve & execute a Uniswap swap using an off-chain EIP-712 signature instead of a prior on-chain approve transaction. The flow should let a relayer or the user submit the signed permit and perform the swap in a single on-chain transaction.
