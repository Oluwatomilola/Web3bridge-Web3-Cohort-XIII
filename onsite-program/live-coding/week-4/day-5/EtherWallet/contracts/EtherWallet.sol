// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

error YOURE_A_THIEF();

contract EtherWallet {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    // this allows the contract to receive funds
    receive() external payable {}

    // this references the contract itself
    // msg.sender: this is the person interacting with the contract

    // optional
    fallback() external {}

    function get_balance() external view returns (uint256) {
        return address(this).balance;
    }

    function transfer(address payable _to, uint256 _amount) external {
        if (owner != msg.sender) {
            revert YOURE_A_THIEF();
        }
        _to.transfer(_amount);
    }
}
