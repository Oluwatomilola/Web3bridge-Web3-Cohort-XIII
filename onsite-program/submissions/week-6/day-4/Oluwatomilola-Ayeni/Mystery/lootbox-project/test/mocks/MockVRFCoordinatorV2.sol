// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MockVRFCoordinatorV2 {
    uint256 public lastRequestId = 1;
    mapping(uint256 => address) public consumers;

    function requestRandomWords(
        bytes32 keyHash,
        uint256 subId,
        uint16 requestConfirmations,
        uint32 callbackGasLimit,
        uint32 numWords,
        bytes calldata extraArgs
    ) external returns (uint256) {
        uint256 requestId = lastRequestId++;
        return requestId;
    }

    function fulfillRandomWords(uint256 requestId, address consumer, uint256[] memory randomWords) external {
        (bool success, ) = consumer.call(abi.encodeWithSignature("fulfillRandomWords(uint256,uint256[])", requestId, randomWords));
        require(success, "Fulfillment failed");
    }
}