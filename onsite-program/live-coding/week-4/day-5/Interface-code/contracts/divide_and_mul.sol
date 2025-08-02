// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract DivideAndMultiply {
    function divide(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    function multiply(uint256 a, uint256 b) public pure returns (uint256) {
        return a * b;
    }
}
