// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ISwapRouter} from "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

contract MockSwapRouter is ISwapRouter {
    function exactInputSingle(ExactInputSingleParams calldata params) external returns (uint256 amountOut) {
        require(block.timestamp <= params.deadline, "Deadline expired");
        IERC20(params.tokenIn).transferFrom(msg.sender, address(this), params.amountIn);
        // Simulate swap: return 90% as output (mock)
        amountOut = params.amountIn * 9 / 10;
        // In real test, transfer output token if needed; here we just return value
    }
}