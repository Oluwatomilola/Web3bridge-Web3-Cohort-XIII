// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

/**
 * @title MessageStorage
 * @dev Store & retrieve a message in a variable
 */
contract MessageStorage {
    string private message;

    function store(string memory newMessage) public {
        message = newMessage;
    }

    function retrieve() public view returns (string memory) {
        return message;
    }
}