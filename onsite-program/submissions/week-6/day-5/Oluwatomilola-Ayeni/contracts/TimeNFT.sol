// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract TimeNFT is ERC721 {
    uint256 private _tokenIdCounter = 1; // Start from 1

    constructor() ERC721("Time NFT", "TME") {}

    function mint() public returns (uint256) {
        uint256 tokenId = _tokenIdCounter;
        _safeMint(msg.sender, tokenId);
        _tokenIdCounter++;
        return tokenId;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        // require(_exists(tokenId), "ERC721: URI query for nonexistent token");
    
        (string memory timeStr, uint256 timestamp) = getCurrentTime();
        

        string memory svg = generateSVG(timeStr);
        
        string memory json = string(abi.encodePacked(
            '{"name": "Dynamic Time NFT #', Strings.toString(tokenId), '",',
            '"description": "An NFT that displays the current blockchain time (updates when viewed).",',
            '"image": "data:image/svg+xml;base64,', Base64.encode(bytes(svg)), '?t=', Strings.toString(timestamp), '",',
            '"attributes": [{"trait_type": "Last Update", "value": "', timeStr, '"}]',
            '}'
        ));
        
        return string(abi.encodePacked("data:application/json;base64,", Base64.encode(bytes(json))));
    }
    
    function getCurrentTime() internal view returns (string memory, uint256) {
        uint256 timestamp = block.timestamp;
        uint256 hour = (timestamp % 86400) / 3600;
        uint256 minute = (timestamp % 3600) / 60;
        uint256 second = timestamp % 60;
        
        string memory hoursStr = hour < 10 ? string(abi.encodePacked("0", Strings.toString(hour))) : Strings.toString(hour);
        string memory minutesStr = minute < 10 ? string(abi.encodePacked("0", Strings.toString(minute))) : Strings.toString(minute);
        string memory secondsStr = second < 10 ? string(abi.encodePacked("0", Strings.toString(second))) : Strings.toString(second);
        
        string memory timeStr = string(abi.encodePacked(hoursStr, ":", minutesStr, ":", secondsStr));
        
        return (timeStr, timestamp);
    }
    
    function generateSVG(string memory timeStr) internal pure returns (string memory) {
        return string(abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" width="400" height="400" viewBox="0 0 400 400">',
            '<rect width="100%" height="100%" fill="#1a1a1a"/>',
            '<circle cx="200" cy="200" r="150" fill="none" stroke="#730A49" stroke-width="10"/>',
            '<text x="50%" y="45%" font-family="Arial" font-size="24" fill="#FFFFFF" text-anchor="middle">Dynamic Time NFT</text>',
            '<text x="50%" y="55%" font-family="Arial" font-size="40" fill="#730A49" text-anchor="middle" dominant-baseline="middle">',
            timeStr,
            '</text>',
            '<text x="50%" y="65%" font-family="Arial" font-size="14" fill="#AAAAAA" text-anchor="middle">Updates when viewed</text>',
            '</svg>'
        ));
    }
}