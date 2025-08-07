// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

import "./Child.sol";

contract Factory {
    address[] children;

    function create_child(address _owner) external {
        _owner = msg.sender;
        Child child = new Child(_owner);
        children.push(address(child));
    }
}
