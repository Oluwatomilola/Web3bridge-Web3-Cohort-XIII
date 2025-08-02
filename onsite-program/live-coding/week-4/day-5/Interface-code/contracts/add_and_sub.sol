// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import "./divide_and_mul.sol";

contract AddAndSubtract is DivideAndMultiply {
    function add(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;
    }

    function subtract(uint256 a, uint256 b) external pure returns (uint256) {
        return a - b;
    }

    function interact_with_divide(uint256 a, uint256 b) external pure returns (uint256) {
        return divide(a, b);
    }

    function interact_with_mul(uint256 a, uint256 b) external pure returns (uint256) {
        return multiply(a, b);
        // return this.do_something(a);
    }

    function do_something(uint256 a) external pure returns (uint256) {
        return a;
    }
}
