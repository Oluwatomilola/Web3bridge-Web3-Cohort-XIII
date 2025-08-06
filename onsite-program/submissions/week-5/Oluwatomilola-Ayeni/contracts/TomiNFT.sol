// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TomiNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;

    event NFTMinted(address indexed recipient, uint256 indexed tokenId, string tokenURI);

    constructor(address initialOwner) ERC721("TomiNFT", "TNFT") Ownable(initialOwner) {}

    function mintNFT(address recipient, string memory tokenURI)
        public
        onlyOwner
        returns (uint256)
    {
        require(recipient != address(0), "Recipient cannot be zero address");
        require(bytes(tokenURI).length > 0, "Token URI cannot be empty");

        _tokenIds = 1; // Set to 1 for single NFT
        uint256 newItemId = _tokenIds;
        _safeMint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        emit NFTMinted(recipient, newItemId, tokenURI);
        return newItemId;
    }
}