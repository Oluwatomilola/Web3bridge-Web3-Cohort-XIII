// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./NFTWithRoles.sol";

contract TokenGatedDAO {
    
    struct Proposal {
        uint id;
        address creator;
        string description;
        uint yesVotes;
        uint noVotes;
        uint endTime;
        bool executed;
    }
    
    NFTWithRoles public nftContract;
    
  
    uint private _proposalCounter;

    mapping(uint => Proposal) public proposals;
    

    mapping(uint => mapping(uint => bool)) public hasVoted;
    
    
    uint public  votingPeriod = 7 days;
    
    modifier onlyTokenHolder() {
        require(nftContract.balanceOf(msg.sender) > 0, "Must own NFT");
        _;
    }
    
    modifier onlyAdmin() {
        require( nftContract.userHasRole(msg.sender, nftContract.adminRole()), "Must have admin role");
        _;
    }
    
    modifier onlyMemberOrAdmin() {
        require( nftContract.userHasRole(msg.sender, nftContract.memberRole()) || nftContract.userHasRole(msg.sender, nftContract.adminRole()),
            "Must have member or admin role");
        _;
    }
    
    constructor(address _nftContract) { require(_nftContract != address(0), "Invalid NFT contract");
        nftContract = NFTWithRoles(_nftContract);
        _proposalCounter = 1;
    }

    function createProposal(string memory description) external onlyAdmin returns (uint) {
        require(bytes(description).length > 0, "Description cannot be empty");
         uint proposalId = _proposalCounter;
        _proposalCounter++;
        
        proposals[proposalId] = Proposal({
            id: proposalId,
            creator: msg.sender,
            description: description,
            yesVotes: 0,
            noVotes: 0,
            endTime: block.timestamp + votingPeriod,
            executed: false
        });
        
        return proposalId;
    }

    function vote(uint proposalId, bool support) external onlyMemberOrAdmin {
        require(proposalId > 0 && proposalId < _proposalCounter, "Invalid proposal");
        
        Proposal storage proposal = proposals[proposalId];
        require(block.timestamp < proposal.endTime, "Voting period ended");
        
        
        uint tokenId = nftContract.getUserTokenId(msg.sender);
        require(tokenId > 0, "No token found");
        require(!hasVoted[proposalId][tokenId], "Already voted");
        
       
        hasVoted[proposalId][tokenId] = true;
        
        if (support) {
            proposal.yesVotes++;
        } else {
            proposal.noVotes++;
        }
    }

    function hasProposalPassed(uint proposalId) external view returns (bool) {
        require(proposalId > 0 && proposalId < _proposalCounter, "Invalid proposal");
        
        Proposal memory proposal = proposals[proposalId];
        require(block.timestamp >= proposal.endTime, "Voting still active");
        
        return proposal.yesVotes > proposal.noVotes;
    }

    function getProposal(uint proposalId) external view returns (
        uint id,
        address creator,
        string memory description,
        uint yesVotes,
        uint noVotes,
        uint endTime,
        bool executed
    ) {
        require(proposalId > 0 && proposalId < _proposalCounter, "Invalid proposal");
        
        Proposal memory proposal = proposals[proposalId];
        return (
            proposal.id,
            proposal.creator,
            proposal.description,
            proposal.yesVotes,
            proposal.noVotes,
            proposal.endTime,
            proposal.executed
        );
    }

    function isVotingActive(uint proposalId) external view returns (bool) {
        require(proposalId > 0 && proposalId < _proposalCounter, "Invalid proposal");
        return block.timestamp < proposals[proposalId].endTime;
    }
    
   
    function getProposalCount() external view returns (uint) {
        return _proposalCounter - 1;
    }
   
    function canVote(address user) external view returns (bool) {
        return nftContract.userHasRole(user, nftContract.memberRole()) ||
               nftContract.userHasRole(user, nftContract.adminRole());
    }
       function canCreateProposal(address user) external view returns (bool) {
        return nftContract.userHasRole(user, nftContract.adminRole());
    }
}