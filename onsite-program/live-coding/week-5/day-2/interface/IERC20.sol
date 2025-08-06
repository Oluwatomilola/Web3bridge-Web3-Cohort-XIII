// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

interface IERC20 {
    //get token name
    function token_name() external pure returns (string memory);

    // get token decimals``
    function get_decimals() external pure returns (uint256);

    // Allows user to transfer token to other users
    function transfer(address _to, uint256 _amount) external returns (bool);

    // Allows a user to give another user spending power on their behalf
    function allowance(address _owner, address _spender) external view returns (uint256);

    // Get total supply of the minted tokens in existent
    function totalSupply() external pure returns (uint256);

    // Get total amount of token in a particular address
    function balanceOf(address _addy) external view returns (uint256);

    // Allows a third party to transfer on a user behalf
    function trasferFrom(address _owner, address _receipient, uint256 _amount) external returns (bool);

    // check if a specific address holds spending power
    function approve(address _spender, uint256 _amount) external returns (bool);
}
