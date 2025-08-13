// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
interface IERC7432 {

    function grantRole(uint tokenId, bytes32 role,uint64 expirationDate ) external;

    function revokeRole(uint256 tokenId, bytes32 role) external;

    function hasRole(uint256 tokenId, bytes32 role) external view returns (bool);


    function roleExpirationDate(uint256 tokenId, bytes32 role) external view returns (uint64);

   
    function isRoleExpired(uint256 tokenId, bytes32 role) external view returns (bool);
}