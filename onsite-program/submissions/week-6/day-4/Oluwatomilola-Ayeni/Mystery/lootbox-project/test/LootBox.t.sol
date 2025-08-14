// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/LootBox.sol";
import "./mocks/MockVRFCoordinatorV2.sol";
import "./mocks/MockERC20.sol";
import "./mocks/MockERC721.sol";
import "./mocks/MockERC1155.sol";

contract LootBoxTest is Test {
    LootBox lootBox;
    MockVRFCoordinatorV2 mockVRF;
    MockERC20 mockERC20;
    MockERC721 mockERC721;
    MockERC1155 mockERC1155;

    uint256 boxFee = 0.1 ether;
    uint256 subscriptionId = 1;
    bytes32 keyHash = bytes32("keyhash");
    address owner = address(this);
    address user = makeAddr("user");

    event BoxOpened(address indexed user, uint256 requestId);
    event RandomnessRequested(uint256 requestId);
    event RandomnessFulfilled(uint256 requestId, uint256 randomWord);
    event RewardDistributed(address indexed user, LootBox.RewardType rewardType, address tokenAddress, uint256 tokenId, uint256 amount);

    function setUp() public {
        mockVRF = new MockVRFCoordinatorV2();
        lootBox = new LootBox(boxFee, subscriptionId, address(mockVRF), keyHash);

        mockERC20 = new MockERC20();
        mockERC721 = new MockERC721();
        mockERC1155 = new MockERC1155();

        // Pre-deposit rewards to lootBox
        mockERC20.mint(address(lootBox), 1000);
        mockERC721.mint(address(lootBox), 1);
        mockERC1155.mint(address(lootBox), 1, 5);

        // Add rewards (weights: ERC20 high, others lower for testing)
        lootBox.addReward(LootBox.RewardType.ERC20, address(mockERC20), 0, 100, 70); // 70% chance
        lootBox.addReward(LootBox.RewardType.ERC721, address(mockERC721), 1, 1, 20);  // 20%
        lootBox.addReward(LootBox.RewardType.ERC1155, address(mockERC1155), 1, 5, 10); // 10%
    }

    function testAddReward() public {
        // Already added in setUp, check totalWeight
        assertEq(lootBox.totalWeight(), 100);

        // Test onlyOwner
        vm.prank(user);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user));
        lootBox.addReward(LootBox.RewardType.ERC20, address(mockERC20), 0, 10, 5);
    }

    function testOpenBox() public {
        vm.deal(user, 1 ether);
        vm.prank(user);
        vm.expectEmit(true, true, false, true);
        emit BoxOpened(user, 1);
        emit RandomnessRequested(1);
        lootBox.openBox{value: boxFee}();

        // Check incorrect fee
        vm.expectRevert("Incorrect fee");
        lootBox.openBox{value: 0}();

        // Check no rewards
        LootBox emptyBox = new LootBox(boxFee, subscriptionId, address(mockVRF), keyHash);
        vm.expectRevert("No rewards available");
        emptyBox.openBox{value: boxFee}();
    }

    function testFulfillRandomWordsAndDistribute() public {
        // Open box to create request
        vm.deal(user, 1 ether);
        vm.prank(user);
        lootBox.openBox{value: boxFee}();
        uint256 requestId = 1;

        // Fulfill with randomWord that selects ERC20 (rand % 100 < 70)
        uint256[] memory randomWords = new uint256[](1);
        randomWords[0] = 50; // 50 % 100 = 50 < 70 -> ERC20
        vm.expectEmit(true, true, false, true);
        emit RandomnessFulfilled(requestId, 50);
        emit RewardDistributed(user, LootBox.RewardType.ERC20, address(mockERC20), 0, 100);
        mockVRF.fulfillRandomWords(requestId, address(lootBox), randomWords);

        assertEq(mockERC20.balanceOf(user), 100);

        // Test ERC721 (rand 75 -> 75 < 90 (70+20))
        vm.prank(user);
        lootBox.openBox{value: boxFee}();
        requestId = 2;
        randomWords[0] = 75;
        mockVRF.fulfillRandomWords(requestId, address(lootBox), randomWords);
        assertEq(mockERC721.ownerOf(1), user);

        // Test ERC1155 (rand 95 -> 95 < 100)
        vm.prank(user);
        lootBox.openBox{value: boxFee}();
        requestId = 3;
        randomWords[0] = 95;
        mockVRF.fulfillRandomWords(requestId, address(lootBox), randomWords);
        assertEq(mockERC1155.balanceOf(user, 1), 5);

        // Invalid request
        randomWords[0] = 0;
        vm.expectRevert("Invalid request");
        mockVRF.fulfillRandomWords(999, address(lootBox), randomWords);
    }

    function testWithdrawFees() public {
        vm.deal(address(lootBox), 1 ether);
        assertEq(address(lootBox).balance, 1 ether);

        lootBox.withdrawFees();
        assertEq(address(lootBox).balance, 0);
        assertEq(owner.balance, 1 ether);

        // Test onlyOwner
        vm.prank(user);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user));
        lootBox.withdrawFees();
    }

    function testUpdateVRFParams() public {
        lootBox.updateVRFParams(200000, 5);
        // No direct assert, but function called successfully

        // Test onlyOwner
        vm.prank(user);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user));
        lootBox.updateVRFParams(200000, 5);
    }
}