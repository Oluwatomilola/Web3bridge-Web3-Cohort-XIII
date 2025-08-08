// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract TicketNft is ERC721 {
    constructor() ERC721("TicketNft", "TNFT") {}
}
