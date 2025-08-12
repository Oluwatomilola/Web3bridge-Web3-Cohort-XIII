// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ISwapRouter} from "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

interface IPermitToken is IERC20 {
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function nonces(address owner) external view returns (uint256);
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}

contract PermitSwap {
    address public immutable uniswapRouter;

    constructor(address _uniswapRouter) {
        uniswapRouter = _uniswapRouter;
    }

    struct PermitData {
        address owner;
        uint256 value;
        uint256 deadline;
        uint8 v;
        bytes32 r;
        bytes32 s;
    }

    function permitAndSwap(
        address tokenIn,
        PermitData calldata permit,
        ISwapRouter.ExactInputSingleParams calldata swapParams
    ) external returns (uint256 amountOut) {
        // Call permit to set allowance for this contract
        IPermitToken(tokenIn).permit(
            permit.owner,
            address(this),
            permit.value,
            permit.deadline,
            permit.v,
            permit.r,
            permit.s
        );

        // Transfer tokens from owner to this contract
        IERC20(tokenIn).transferFrom(permit.owner, address(this), swapParams.amountIn);

        // Approve the Uniswap router
        IERC20(tokenIn).approve(uniswapRouter, swapParams.amountIn);

        // Execute the swap
        amountOut = ISwapRouter(uniswapRouter).exactInputSingle(swapParams);
    }
}