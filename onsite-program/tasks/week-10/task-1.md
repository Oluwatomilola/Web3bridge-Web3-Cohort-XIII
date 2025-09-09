# Web3 Frontend Development Task 1

## Objective

Build a frontend application to interact with the provided staking smart contract, demonstrating proficiency in dApp development and contract integration.

## Requirements

### 1. Frontend Development

-   **User Interface**:

    -   Wallet connection functionality
    -   Staking form with amount input
    -   Withdrawal interface
    -   Rewards claim section
    -   Emergency withdrawal option
    -   All Stake position display
    -   User Stake position display

-   **Data Display**:
    -   Current staking position
    -   Pending rewards
    -   Time until unlock
    -   Current APR
    -   Total protocol statistics (total staked, reward rate, etc.)

### 2. Contract Integration

-   **Contract Functions to Implement**:

    -   `stake()`
    -   `withdraw()`
    -   `claimRewards()`
    -   `emergencyWithdraw()`

-   **Data Retrieval (Read Functions / Public Variables)**:
    -   User’s stake(s)
    -   User’s pending rewards
    -   Unlock time per stake position
    -   Contract-wide statistics:
        -   total staked
        -   reward rate
        -   protocol-level APR

### 3. Technology Stack

-   Framework: React/Next.js (JavaScript/TypeScript)
-   Web3 Library: `ethers.js` or `viem`

### 4. Additional Information

-   **Contract**: deploy [staking contract](https://github.com/Timidan/Staking/)
-   **Network**: Sepolia

## Submission Requirements

1. GitHub repository containing:

    - Frontend application
    - README with setup instructions

2. Deployed frontend application URL
