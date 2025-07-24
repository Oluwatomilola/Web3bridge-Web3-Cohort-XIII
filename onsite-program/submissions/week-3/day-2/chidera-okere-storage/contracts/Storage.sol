// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title BasicStorage
 * @dev A simple smart contract to demonstrate storing and retrieving data on the blockchain.
 */
contract Storage {
    // State variables to store our data
    uint256 public storedNumber;
    string public storedMessage;

    /**
     * @dev Stores a new unsigned integer value.
     * @param _number The number to store.
     */
    function setNumber(uint256 _number) public {
        storedNumber = _number;
    }

    /**
     * @dev Retrieves the current stored unsigned integer value.
     * @return The currently stored number.
     */
    function getNumber() public view returns (uint256) {
        return storedNumber;
    }

    /**
     * @dev Stores a new string message.
     * @param _message The message to store.
     */
    function setMessage(string memory _message) public {
        storedMessage = _message;
    }

    /**
     * @dev Retrieves the current stored string message.
     * @return The currently stored message.
     */
    function getMessage() public view returns (string memory) {
        return storedMessage;
    }
}