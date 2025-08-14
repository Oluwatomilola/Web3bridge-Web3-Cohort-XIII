// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "chainlink-evm/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
import "chainlink-evm/contracts/src/v0.8/vrf/interfaces/VRFCoordinatorV2Interface.sol";

contract LootBox is Ownable, VRFConsumerBaseV2 {
    enum RewardType { NONE, ERC20, ERC721, ERC1155 }

    struct Reward {
        RewardType rewardType;
        address tokenAddress;
        uint256 tokenId; // For ERC721/ERC1155; 0 for ERC20
        uint256 amount;  // For ERC20/ERC1155; 1 for ERC721
        uint256 weight;
    }

    Reward[] public rewards;
    uint256 public totalWeight;
    uint256 public boxFee;

    // VRF parameters
    uint64 public s_subscriptionId;
    bytes32 public keyHash;
    uint32 public callbackGasLimit = 100000;
    uint16 public requestConfirmations = 3;
    uint32 public numWords = 1;

    VRFCoordinatorV2Interface public COORDINATOR;

    // Mapping for pending requests
    mapping(uint256 => address) public requestToUser;

    // Events
    event BoxOpened(address indexed user, uint256 requestId);
    event RandomnessRequested(uint256 requestId);
    event RandomnessFulfilled(uint256 requestId, uint256 randomWord);
    event RewardDistributed(address indexed user, RewardType rewardType, address tokenAddress, uint256 tokenId, uint256 amount);

    constructor(
        uint256 _boxFee,
        uint64 _subscriptionId,
        address _vrfCoordinator,
        bytes32 _keyHash
    ) VRFConsumerBaseV2(_vrfCoordinator) Ownable(msg.sender) {
        boxFee = _boxFee;
        s_subscriptionId = _subscriptionId;
        keyHash = _keyHash;
        COORDINATOR = VRFCoordinatorV2Interface(_vrfCoordinator);
    }

    // Admin function to add a reward
    function addReward(
        RewardType _type,
        address _tokenAddress,
        uint256 _tokenId,
        uint256 _amount,
        uint256 _weight
    ) external onlyOwner {
        require(_weight > 0, "Weight must be positive");
        rewards.push(Reward({
            rewardType: _type,
            tokenAddress: _tokenAddress,
            tokenId: _tokenId,
            amount: _amount,
            weight: _weight
        }));
        totalWeight += _weight;
    }

    // User function to open a box
    function openBox() external payable {
        require(msg.value == boxFee, "Incorrect fee");
        require(totalWeight > 0, "No rewards available");

        uint256 requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );

        requestToUser[requestId] = msg.sender;
        emit BoxOpened(msg.sender, requestId);
        emit RandomnessRequested(requestId);
    }

    // VRF fulfillment callback
    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {
        address user = requestToUser[requestId];
        require(user != address(0), "Invalid request");

        uint256 randomWord = randomWords[0];
        emit RandomnessFulfilled(requestId, randomWord);

        // Select reward based on weighted random
        uint256 rand = randomWord % totalWeight;
        uint256 cumulative = 0;
        Reward memory selected;
        for (uint256 i = 0; i < rewards.length; i++) {
            cumulative += rewards[i].weight;
            if (rand < cumulative) {
                selected = rewards[i];
                break;
            }
        }

        // Distribute reward
        if (selected.rewardType == RewardType.ERC20) {
            IERC20(selected.tokenAddress).transfer(user, selected.amount);
        } else if (selected.rewardType == RewardType.ERC721) {
            IERC721(selected.tokenAddress).safeTransferFrom(address(this), user, selected.tokenId);
        } else if (selected.rewardType == RewardType.ERC1155) {
            IERC1155(selected.tokenAddress).safeTransferFrom(address(this), user, selected.tokenId, selected.amount, "");
        }

        emit RewardDistributed(user, selected.rewardType, selected.tokenAddress, selected.tokenId, selected.amount);

        delete requestToUser[requestId];
    }

    // Admin function to withdraw ETH fees
    function withdrawFees() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    // Admin function to update VRF params (if needed)
    function updateVRFParams(uint32 _callbackGasLimit, uint16 _requestConfirmations) external onlyOwner {
        callbackGasLimit = _callbackGasLimit;
        requestConfirmations = _requestConfirmations;
    }
}