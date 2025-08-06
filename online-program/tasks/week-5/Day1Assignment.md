# Staking Contract Assignment

## Requirements

Build a staking contract that accepts Token A deposits and mints Token B rewards at 1:1 ratio with time-locked withdrawals.

### Contract Features
- Stake Token A, mint Token B immediately (1:1 ratio)
- Set lock period during deployment
- Unstake burns Token B, returns Token A after lock period
- Track user stakes and unlock times

### Required Functions
```solidity
function stake(uint256 amount) external;
function unstake(uint256 amount) external;
function getStakeInfo(address user) external view returns (uint256 amount, uint256 unlockTime);
```

### Test all cases

### write an automated script to ensure the flow works correctly onchain