// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/LootBox.sol";
import "../test/mocks/MockVRFCoordinatorV2.sol";

contract DeployLootBox is Script {
    function run() external {
        vm.startBroadcast();
        // Deploy mock VRF coordinator for local testing
        MockVRFCoordinatorV2 mockVRF = new MockVRFCoordinatorV2();
        LootBox lootBox = new LootBox(0.1 ether, 1, address(mockVRF), bytes32("keyhash"));
        vm.stopBroadcast();
    }
}