// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy.ts
 */

 // CONTRACT-ADDRESS: 0x698c5DeDfe31d9addEa4d914Cd590A8757a4679D
 // VERIFIED-URL: https://sepolia-blockscout.lisk.com/address/0x698c5DeDfe31d9addEa4d914Cd590A8757a4679D#code

contract Storage {

    uint256 number;

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        return number;
    }
}