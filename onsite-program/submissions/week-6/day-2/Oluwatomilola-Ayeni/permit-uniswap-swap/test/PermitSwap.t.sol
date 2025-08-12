// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {PermitSwap} from "../src/PermitSwap.sol";
import {MockERC2612} from "./MockERC2612.sol";
import {MockSwapRouter} from "./MockSwapRouter.sol";
import {ISwapRouter} from "@uniswap/v3-periphery/contracts/ISwapRouter.sol";

contract PermitSwapTest is Test {
    PermitSwap permitSwap;
    MockERC2612 token;
    MockSwapRouter router;
    address owner;
    address relayer;
    uint256 ownerPrivateKey;

    function setUp() public {
        ownerPrivateKey = 0xA11CE; // Test private key
        owner = vm.addr(ownerPrivateKey);
        relayer = makeAddr("relayer");

        token = new MockERC2612("MockToken", "MTK", 1000 ether);
        router = new MockSwapRouter();
        permitSwap = new PermitSwap(address(router));

        // Mint tokens to owner
        vm.prank(address(this)); // Initial minter
        token.transfer(owner, 100 ether);
    }

    function testPermitAndSwap() public {
        uint256 amountIn = 10 ether;
        uint256 deadline = block.timestamp + 1 hours;
        uint256 nonce = token.nonces(owner);

        // Generate EIP-712 digest
        bytes32 structHash = keccak256(
            abi.encode(
                keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                owner,
                address(permitSwap),
                amountIn,
                nonce,
                deadline
            )
        );
        bytes32 digest = keccak256(abi.encodePacked("\x19\x01", token.DOMAIN_SEPARATOR(), structHash));

        // Sign the digest
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, digest);

        // Prepare permit data
        PermitSwap.PermitData memory permit = PermitSwap.PermitData({
            owner: owner,
            value: amountIn,
            deadline: deadline,
            v: v,
            r: r,
            s: s
        });

        // Prepare swap params (mock output token is address(0) for simplicity)
        ISwapRouter.ExactInputSingleParams memory swapParams = ISwapRouter.ExactInputSingleParams({
            tokenIn: address(token),
            tokenOut: address(0), // Mock; in real, use actual token
            fee: 3000,
            recipient: owner,
            deadline: deadline,
            amountIn: amountIn,
            amountOutMinimum: 0,
            sqrtPriceLimitX96: 0
        });

        // Execute as relayer
        uint256 initialBalance = token.balanceOf(owner);
        vm.prank(relayer);
        uint256 amountOut = permitSwap.permitAndSwap(address(token), permit, swapParams);

        // Assertions
        assertEq(token.balanceOf(owner), initialBalance - amountIn, "Tokens not transferred");
        assertEq(amountOut, amountIn * 9 / 10, "Swap output mismatch");
        assertEq(token.allowance(owner, address(permitSwap)), 0, "Allowance not used"); // Spent after transfer
    }

    function testInvalidSignatureReverts() public {
        // Similar setup, but corrupt signature (e.g., wrong v)
        // ... (Add fuzzing or manual invalid cases for robustness)
        // Use assertRevert or expectRevert
    }
}