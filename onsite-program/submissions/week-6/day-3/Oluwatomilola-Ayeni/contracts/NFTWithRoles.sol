// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IERC7432.sol";

contract NFTWithRoles is ERC721, Ownable, IERC7432 {
    
    struct RoleData {
        bool exists;
        uint64 expirationDate;
    }
    
    
    bytes32 public memberRole = keccak256("MEMBER");
    bytes32 public adminRole = keccak256("ADMIN");
    
   
    mapping(uint => mapping(bytes32 => RoleData)) private _tokenRoles;
    

    uint private _tokenIdCounter;
    
    constructor(string memory name, string memory symbol) 
        ERC721(name, symbol) 
        Ownable(msg.sender) 
    {
        _tokenIdCounter = 1;
    }
    

    function mint(address to) external onlyOwner returns (uint) {
        uint tokenId = _tokenIdCounter;
        _tokenIdCounter++;
        _safeMint(to, tokenId);
        return tokenId;
    }
    
   
    function grantRole(uint tokenId,bytes32 role,uint64 expirationDate ) external  onlyOwner {
        require(_ownerOf(tokenId) != address(0), "Token does not exist");
        require(expirationDate > block.timestamp, "Expiration must be in future");
        require(role == memberRole || role == adminRole, "Invalid role");
        
        _tokenRoles[tokenId][role] = RoleData({
            exists: true,
            expirationDate: expirationDate
        });
    }
    
  
    function revokeRole(uint tokenId, bytes32 role) external  onlyOwner {
        require(_ownerOf(tokenId) != address(0), "Token does not exist");
        delete _tokenRoles[tokenId][role];
    }
    
   
    function hasRole(uint tokenId, bytes32 role) external view returns (bool) {
        RoleData memory roleData = _tokenRoles[tokenId][role];
        return roleData.exists && block.timestamp < roleData.expirationDate;
    }
    
   
    function roleExpirationDate(uint tokenId, bytes32 role) external view returns (uint64) {
        RoleData memory roleData = _tokenRoles[tokenId][role];
        return roleData.exists ? roleData.expirationDate : 0;
    }
    
    
    function isRoleExpired(uint tokenId, bytes32 role) external view returns (bool) {
        RoleData memory roleData = _tokenRoles[tokenId][role];
        if (!roleData.exists) return false;
        return block.timestamp >= roleData.expirationDate;
    }
    
    
    function getUserTokenId(address user) external view returns (uint) {
        for (uint i = 1; i < _tokenIdCounter; i++) {
            if (_ownerOf(i) == user) {
                return i;
            }
        }
        return 0;
    }
    

    function userHasRole(address user, bytes32 role) external view returns (bool) {
        for (uint i = 1; i < _tokenIdCounter; i++) {
            if (_ownerOf(i) == user) {
                RoleData memory roleData = _tokenRoles[i][role];
                return roleData.exists && block.timestamp < roleData.expirationDate;
            }
        }
        return false;
    }
}