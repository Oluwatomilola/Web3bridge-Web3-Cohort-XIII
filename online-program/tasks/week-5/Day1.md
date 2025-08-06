# Multi-Signature Wallet Assignment

## Requirements

Build a multi-sig wallet contract where multiple owners must approve transactions before execution.

### Contract Features
- Deploy with owners list and required confirmations
- Submit transaction (destination, value, data)
- Confirm/revoke confirmations
- Execute when threshold reached
- Deposit ETH

### Events
```solidity
event TransactionSubmitted(uint256 indexed txId, address indexed to, uint256 value);
event TransactionConfirmed(uint256 indexed txId, address indexed owner);
event TransactionRevoked(uint256 indexed txId, address indexed owner);
event TransactionExecuted(uint256 indexed txId);
```

### Test all appropriate cases