// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "./MultisigWallet.sol";

contract MultisigFactory {
    address[] public wallets;

    function createWallet(address[] calldata owners, uint required) external returns (address) {
        MultisigWallet wallet = new MultisigWallet(owners, required);
        wallets.push(address(wallet));
        return address(wallet);
    }

    function getWallets() external view returns (address[] memory) {
        return wallets;
    }
}